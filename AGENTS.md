# AI Engineering Foundation

This repository contains reusable instructions, skills, and reference material for AI-assisted software engineering.

## Operating principles

- Treat the user's request and the target repository as the source of truth.
- Inspect the existing codebase, conventions, and toolchain before proposing or making changes.
- Prefer the smallest complete solution that meets the requirements. Avoid speculative abstractions and unnecessary dependencies.
- Separate durable engineering rules from task-specific workflows and reference knowledge.
- Validate changes with the relevant checks and report exactly what was and was not executed.
- Never claim a build, test, deployment, or security check succeeded unless it was actually run and its result observed.
- Never expose secrets, credentials, personal data, or sensitive production values in code, logs, examples, or documentation.
- Do not perform destructive operations, deploy, or modify external systems without the user's authorization.

## Using this foundation

- Cursor-specific project rules live in `.cursor/rules/*.mdc`.
- Reusable task workflows live in `.agents/skills/<skill-name>/SKILL.md`.
- Reusable technical knowledge lives in `docs/ai-foundation/references/`.
- Read only the instructions and references relevant to the current task.
- Treat repository-specific conventions as authoritative when they intentionally differ from generic examples in this foundation.
- Do not assume that every AI coding tool automatically discovers every directory. Use the tool's documented discovery mechanism and link to shared material where needed.

## Skills

Before scaffolding a new Nuxt business application, read `.agents/skills/scaffold-nuxt-app/SKILL.md`. Apply its defaults only when they fit the user's requirements and the existing repository.
