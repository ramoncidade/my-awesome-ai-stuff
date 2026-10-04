---
description: Durable engineering principles for code changes across the repository
applyTo: "**"
---

# Engineering Standards

- Inspect relevant files and existing patterns before editing.
- Follow the repository's established language, framework, architecture, naming, and formatting conventions.
- Prefer simple, explicit implementations over speculative abstractions and unnecessary frameworks.
- Keep HTTP handlers, UI components, domain rules, and persistence responsibilities appropriately separated.
- Validate untrusted data at system boundaries; do not rely on client-side validation alone.
- Handle errors intentionally. Do not silently swallow exceptions or expose internal details to users.
- Add or update automated tests for changed behavior when a suitable test setup exists.
- Keep changes scoped to the requested task. Do not reformat or rewrite unrelated files.
- Do not add dependencies unless they provide clear value; explain significant additions.
- Never claim a check passed unless it was executed and its result observed.
- Do not commit secrets, tokens, credentials, private keys, or production data.
- Ask before destructive operations, deployments, or changes to external systems.
