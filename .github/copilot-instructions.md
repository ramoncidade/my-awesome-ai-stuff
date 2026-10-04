# GitHub Copilot Instructions

These instructions apply to code changes throughout this repository. Follow relevant repository-specific guidance and inspect existing code before making changes.

## Engineering principles

- Treat the user's request and the target repository as the source of truth.
- Inspect relevant files, architecture, package manager, conventions, and available checks before editing.
- Prefer the smallest complete solution that meets requirements. Avoid speculative abstractions and unnecessary dependencies.
- Keep changes scoped to the task; do not rewrite unrelated code.
- Separate transport, business logic, and persistence responsibilities where appropriate without introducing unnecessary layers.
- Validate untrusted input at server boundaries.
- Handle errors intentionally. Do not silently swallow exceptions or expose internal details to users.
- Add or update tests for changed behavior when a suitable test setup exists.
- Never claim a test, build, deployment, or security check succeeded unless it was actually run and its result observed.
- Never commit secrets, credentials, private keys, tokens, or production data.
- Ask before destructive operations, deployments, or changes to external systems.

## Security and privacy

- Enforce authentication and authorization server-side for protected operations.
- Use parameterized queries or safe ORM APIs; never concatenate untrusted values into SQL or shell commands.
- Keep secrets in environment variables or a managed secret store.
- Do not log passwords, access tokens, session identifiers, payment data, or unnecessary personal information.
- Consider CSRF, CORS, SSRF, injection, open redirects, file upload risks, and rate limiting when relevant.
- Return safe error messages to clients and protect internal diagnostics.

## Testing and verification

- Identify relevant test, lint, type-check, build, and static-analysis commands before changing code.
- Prefer deterministic tests and isolate external systems.
- Add regression tests for bug fixes when practical.
- Run the narrowest useful checks first, then broader checks when feasible.
- Report the exact checks run, their outcomes, and checks not run with reasons.

## Using this repository's AI foundation

- Cursor-specific rules are in `.cursor/rules/`; GitHub Copilot-specific guidance is in `.github/copilot-instructions.md` and `.github/instructions/`.
- Reusable task workflows live in `.agents/skills/`. A compatible skill may also be mirrored under `.github/skills/` for discovery in Copilot environments.
- Reusable technical knowledge lives in `docs/ai-foundation/`.
- Read only the instructions and references relevant to the current task.
- Treat defaults in examples and skills as starting points, not mandates. Explicit requirements and existing repository conventions take precedence.
- Do not assume a tool automatically discovers files outside its documented discovery mechanism.

Before scaffolding a new Nuxt business application, consult `.agents/skills/scaffold-nuxt-app/SKILL.md` or its Copilot-compatible mirror at `.github/skills/scaffold-nuxt-app/SKILL.md`.