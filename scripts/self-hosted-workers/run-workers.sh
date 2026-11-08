#!/usr/bin/env bash
# Start one Cursor self-hosted worker per directory under this folder.
# Identity stays in each directory's worker-data. This script never signals
# the worker process that is an ancestor of the current session.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=0
READY_TIMEOUT="${READY_TIMEOUT:-60}"

if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=1
fi

resolve_agent() {
    if [[ -n "${CURSOR_AGENT_BIN:-}" && -x "${CURSOR_AGENT_BIN}" ]]; then
        printf '%s\n' "$CURSOR_AGENT_BIN"
        return 0
    fi
    if [[ -x "${HOME}/.local/bin/agent" ]]; then
        printf '%s\n' "${HOME}/.local/bin/agent"
        return 0
    fi
    if command -v agent >/dev/null 2>&1; then
        command -v agent
        return 0
    fi
    return 1
}

session_worker_pid() {
    local pid="$$"
    local args cmd
    while [[ "$pid" -gt 1 ]]; do
        if [[ -r "/proc/${pid}/cmdline" ]]; then
            args=()
            while IFS= read -r -d '' arg; do
                args+=("$arg")
            done < "/proc/${pid}/cmdline" || true
            for cmd in "${args[@]}"; do
                if [[ "$cmd" == "worker" ]]; then
                    printf '%s\n' "$pid"
                    return 0
                fi
            done
        fi
        pid="$(awk '/^PPid:/ {print $2}' "/proc/${pid}/status" 2>/dev/null || echo 1)"
        [[ -n "$pid" ]] || pid=1
    done
    return 1
}

is_session_related() {
    local candidate="$1"
    local pid="${SESSION_WORKER_PID:-}"
    [[ -n "$pid" ]] || return 1
    while [[ "$pid" -gt 1 ]]; do
        [[ "$pid" == "$candidate" ]] && return 0
        pid="$(awk '/^PPid:/ {print $2}' "/proc/${pid}/status" 2>/dev/null || echo 1)"
        [[ -n "$pid" ]] || return 1
    done
    return 1
}

process_has_children() {
    local pid="$1"
    local children
    children="$(ps --no-headers --ppid "$pid" -o pid= 2>/dev/null || true)"
    [[ -n "${children// /}" ]]
}

read_argv() {
    local pid="$1"
    if [[ ! -r "/proc/${pid}/cmdline" ]]; then
        return 1
    fi
    while IFS= read -r -d '' arg; do
        printf '%s\0' "$arg"
    done < "/proc/${pid}/cmdline"
    return 0
}

worker_dirs_from_argv() {
    local worker_root="$1"
    local arg="" next=""
    local -a dirs=()
    while IFS= read -r -d '' arg; do
        if [[ "$arg" == --worker-dir=* ]]; then
            next="${arg#--worker-dir=}"
        elif [[ "$arg" == "--worker-dir" ]]; then
            IFS= read -r -d '' next || true
        else
            continue
        fi
        if [[ "$next" == "." ]]; then
            next="$worker_root"
        elif [[ "$next" != /* ]]; then
            next="${worker_root}/${next}"
        fi
        dirs+=("$(realpath "$next")")
    done
    if [[ ${#dirs[@]} -eq 0 ]]; then
        return 0
    fi
    printf '%s\n' "${dirs[@]}" | sort -u
}

list_worker_pids() {
    local worker_root="$1"
    local pid cwd arg is_worker
    for pid in /proc/[0-9]*; do
        pid="${pid#/proc/}"
        [[ "$pid" =~ ^[0-9]+$ ]] || continue
        cwd="$(readlink "/proc/${pid}/cwd" 2>/dev/null || true)"
        [[ "$cwd" == "$worker_root" ]] || continue
        is_worker=0
        while IFS= read -r -d '' arg; do
            if [[ "$arg" == "worker" ]]; then
                is_worker=1
                break
            fi
        done < <(read_argv "$pid" 2>/dev/null || true)
        [[ "$is_worker" -eq 1 ]] || continue
        if ! read_argv "$pid" | grep -qz -- '--data-dir'; then
            continue
        fi
        printf '%s\n' "$pid"
    done
}

discover_worker_dirs() {
    local worker_root="$1"
    local name="$2"
    local top repo origin base branch score prev gitmeta
    local -a repos=()

    if top="$(git -C "$worker_root" rev-parse --show-toplevel 2>/dev/null)"; then
        if [[ "$(realpath "$top")" == "$(realpath "$worker_root")" ]]; then
            printf '%s\n' "$(realpath "$worker_root")"
            return 0
        fi
    fi

    while IFS= read -r gitmeta; do
        [[ -n "$gitmeta" ]] || continue
        repos+=("$(realpath "$(dirname "$gitmeta")")")
    done < <(find "$worker_root" -mindepth 2 -maxdepth 2 \( -type d -name .git -o -type f -name .git \) | sort)

    if [[ ${#repos[@]} -eq 0 ]]; then
        printf '%s\n' "$(realpath "$worker_root")"
        return 0
    fi

    declare -A best_score=()
    declare -A best_repo=()
    for repo in "${repos[@]}"; do
        origin="$(git -C "$repo" remote get-url origin 2>/dev/null || true)"
        [[ -n "$origin" ]] || origin="local:${repo}"
        base="$(basename "$repo")"
        score=0
        [[ "$base" == "$name" ]] && score=$((score + 100))
        [[ "$base" == "${name}-app" ]] && score=$((score + 30))
        [[ "$base" != *"-wt-"* && "$base" != app--* ]] && score=$((score + 40))
        branch="$(git -C "$repo" rev-parse --abbrev-ref HEAD 2>/dev/null || true)"
        [[ "$branch" != "HEAD" ]] && score=$((score + 5))
        prev="${best_score[$origin]:--1}"
        if [[ "$score" -gt "$prev" || ( "$score" -eq "$prev" && "$repo" < "${best_repo[$origin]}" ) ]]; then
            best_score["$origin"]="$score"
            best_repo["$origin"]="$repo"
        fi
    done

    for origin in "${!best_repo[@]}"; do
        printf '%s\t%s\n' "${best_score[$origin]}" "${best_repo[$origin]}"
    done | sort -t $'\t' -k1,1nr -k2,2 | cut -f2-
}

dirs_match() {
    local expected="$1"
    local actual="$2"
    [[ "$(printf '%s\n' "$expected" | sed '/^$/d' | sort)" == "$(printf '%s\n' "$actual" | sed '/^$/d' | sort)" ]]
}

stop_pid() {
    local pid="$1"
    if is_session_related "$pid"; then
        printf 'Refusing to signal PID %s because it hosts this session.\n' "$pid" >&2
        exit 1
    fi
    if [[ "$DRY_RUN" -eq 1 ]]; then
        printf '  dry-run: would stop PID %s\n' "$pid"
        return 0
    fi
    kill -TERM "$pid" 2>/dev/null || true
    local i
    for ((i = 0; i < 20; i++)); do
        kill -0 "$pid" 2>/dev/null || return 0
        sleep 0.5
    done
    if is_session_related "$pid"; then
        printf 'Refusing to kill PID %s because it hosts this session.\n' "$pid" >&2
        exit 1
    fi
    kill -KILL "$pid" 2>/dev/null || true
    sleep 0.5
}

wait_for_ready() {
    local log_file="$1"
    local offset="$2"
    local pid="$3"
    local deadline=$((SECONDS + READY_TIMEOUT))
    local chunk
    while (( SECONDS < deadline )); do
        if ! kill -0 "$pid" 2>/dev/null; then
            chunk="$(tail -c +"$((offset + 1))" "$log_file" 2>/dev/null || true)"
            printf '%s\n' "$chunk" | tail -n 20 >&2
            return 1
        fi
        chunk="$(tail -c +"$((offset + 1))" "$log_file" 2>/dev/null || true)"
        if [[ "$chunk" == *"Worker is now running"* ]]; then
            return 0
        fi
        if [[ "$chunk" == *"Error starting"* || "$chunk" == *"failed to run command"* ]]; then
            printf '%s\n' "$chunk" | tail -n 20 >&2
            return 1
        fi
        sleep 1
    done
    return 1
}

start_worker() {
    local name="$1"
    local worker_root="$2"
    local log_file="$3"
    shift 3
    local -a worker_dirs=("$@")
    local -a command=("$AGENT" worker --name "$name" --data-dir worker-data)
    local dir
    for dir in "${worker_dirs[@]}"; do
        command+=(--worker-dir "$dir")
    done
    command+=(start)

    if [[ "$DRY_RUN" -eq 1 ]]; then
        printf '  dry-run command:'
        printf ' %q' "${command[@]}"
        printf '\n'
        return 0
    fi

    mkdir -p "${worker_root}/worker-data" "$(dirname "$log_file")"
    {
        printf '\n[%s] Starting worker: %s\n' "$(date '+%Y-%m-%d %H:%M:%S%z')" "$name"
        printf '[%s] Command:' "$(date '+%Y-%m-%d %H:%M:%S%z')"
        printf ' %q' "${command[@]}"
        printf '\n'
    } >> "$log_file"

    local offset pid pid_file
    offset="$(wc -c < "$log_file")"
    pid_file="$(mktemp)"
    (
        cd "$worker_root"
        setsid "${command[@]}" >> "$log_file" 2>&1 < /dev/null &
        printf '%s\n' "$!"
    ) > "$pid_file"
    pid="$(cat "$pid_file" 2>/dev/null || true)"
    rm -f "$pid_file"

    if [[ -z "$pid" ]] || ! kill -0 "$pid" 2>/dev/null; then
        sleep 0.5
        pid="$(list_worker_pids "$worker_root" | head -n 1 || true)"
    fi

    if [[ -z "$pid" ]] || ! kill -0 "$pid" 2>/dev/null; then
        printf 'Failed to start worker: %s; see %s\n' "$name" "$log_file" >&2
        return 1
    fi

    if wait_for_ready "$log_file" "$offset" "$pid"; then
        printf 'Started worker: %s (PID %s)\n' "$name" "$pid"
        return 0
    fi

    printf 'Worker %s (PID %s) did not report ready; see %s\n' "$name" "$pid" "$log_file" >&2
    return 1
}

if ! AGENT="$(resolve_agent)"; then
    printf 'Cursor CLI command agent was not found. Set CURSOR_AGENT_BIN or install it at %s.\n' "${HOME}/.local/bin/agent" >&2
    exit 1
fi

SESSION_WORKER_PID="$(session_worker_pid || true)"
if [[ -n "$SESSION_WORKER_PID" ]]; then
    session_cwd="$(readlink "/proc/${SESSION_WORKER_PID}/cwd" 2>/dev/null || true)"
    printf 'Protecting the worker that hosts this session (PID %s, cwd %s).\n' "$SESSION_WORKER_PID" "${session_cwd:-unknown}"
fi

status=0
for worker_root in "$ROOT"/*/; do
    [[ -d "$worker_root" ]] || continue
    worker_root="$(realpath "$worker_root")"
    name="$(basename "$worker_root")"
    log_file="${worker_root}/logs/worker.log"
    lock_file="${worker_root}/worker-data/worker.lock"

    mapfile -t desired_dirs < <(discover_worker_dirs "$worker_root" "$name")
    if [[ ${#desired_dirs[@]} -eq 0 ]]; then
        printf 'No workspace found for %s\n' "$name" >&2
        status=1
        continue
    fi

    mapfile -t running_pids < <(list_worker_pids "$worker_root" | sort -u)
    protected=0
    for pid in "${running_pids[@]}"; do
        if is_session_related "$pid"; then
            protected=1
            break
        fi
    done
    if [[ "$protected" -eq 1 || ( -n "$SESSION_WORKER_PID" && "$(readlink "/proc/${SESSION_WORKER_PID}/cwd" 2>/dev/null || true)" == "$worker_root" ) ]]; then
        printf 'Leaving %s running. This session is using it.\n' "$name"
        printf '  workspace:'
        printf ' %s' "${desired_dirs[@]}"
        printf '\n'
        continue
    fi

    running_dirs=""
    holder=""
    if [[ ${#running_pids[@]} -gt 0 ]]; then
        holder="${running_pids[0]}"
        if [[ -e "$lock_file" ]]; then
            lock_pids="$(fuser "$lock_file" 2>/dev/null || true)"
            for pid in $lock_pids; do
                holder="$pid"
                break
            done
        fi
        running_dirs="$(read_argv "$holder" | worker_dirs_from_argv "$worker_root" || true)"
    fi

    expected_dirs="$(printf '%s\n' "${desired_dirs[@]}")"
    if [[ ${#running_pids[@]} -gt 0 ]] && dirs_match "$expected_dirs" "$running_dirs"; then
        printf 'Already running: %s (PID %s)\n' "$name" "$holder"
        for pid in "${running_pids[@]}"; do
            [[ "$pid" == "$holder" ]] && continue
            if process_has_children "$pid"; then
                printf '  leaving extra PID %s because it has child processes\n' "$pid"
                continue
            fi
            printf '  stopping extra PID %s\n' "$pid"
            stop_pid "$pid"
        done
        continue
    fi

    busy=0
    for pid in "${running_pids[@]}"; do
        if process_has_children "$pid"; then
            printf 'Leaving %s running (PID %s). It has child processes.\n' "$name" "$pid"
            busy=1
            break
        fi
    done
    [[ "$busy" -eq 0 ]] || continue

    if [[ ${#running_pids[@]} -gt 0 ]]; then
        printf 'Restarting %s so its workspace matches the git checkout.\n' "$name"
        printf '  from:'
        if [[ -n "$running_dirs" ]]; then
            printf ' %s' $running_dirs
        else
            printf ' (no --worker-dir)'
        fi
        printf '\n  to:'
        printf ' %s' "${desired_dirs[@]}"
        printf '\n'
        for pid in "${running_pids[@]}"; do
            stop_pid "$pid"
        done
    else
        printf 'Starting %s\n' "$name"
        printf '  workspace:'
        printf ' %s' "${desired_dirs[@]}"
        printf '\n'
    fi

    if ! start_worker "$name" "$worker_root" "$log_file" "${desired_dirs[@]}"; then
        status=1
    fi
done

exit "$status"
