# Self-hosted worker launchers

`run-workers.sh`, `run-workers.ps1`, and `run-workers.cmd` start one Cursor self-hosted worker for each subdirectory of the folder they are launched from.

These files are safe to store in git. They contain no tokens, passwords, API keys, or session cookies. The `agent` command uses the Cursor login that already exists on the machine, outside this repository.

Do not add these runtime directories to git:

- `worker-data/` holds the worker identity and local runtime state
- `logs/` holds worker logs, including local paths and worker ids

On this machine the copies that actually start workers live in the parent workers directory, next to `ai-toolbox`, `brecho`, `caminha`, `my-awesome-ai-stuff`, and `the-home-music`. `run-workers.cmd` runs `./run-workers.sh` from its own directory. Running the copy inside this repository looks for worker folders under `scripts/self-hosted-workers/`, not in that parent directory.
