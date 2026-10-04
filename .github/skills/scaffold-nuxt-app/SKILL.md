---
name: scaffold-nuxt-app
description: Plan and scaffold a maintainable Nuxt business application, including architecture, persistence, security, testing, and local development setup. Use when creating a new application or establishing its initial foundation.
---

# Scaffold a Nuxt Business Application

## Goal

Create a working, maintainable foundation for a business application. Optimize for a complete, verifiable vertical slice rather than a large collection of disconnected screens.

This skill is a starting point, not a mandate to use every technology listed below. Confirm requirements and inspect the repository before selecting the stack.

## Default stack

Use these defaults when appropriate and consistent with the user's request:

- Node.js 20 or a compatible supported LTS release, with the version documented and pinned consistently.
- Nuxt 3, Vue 3, and TypeScript with strict checking.
- Nuxt/Nitro server routes for backend endpoints when a separate backend is not required.
- PrimeVue 4 and PrimeIcons for UI components when a component library is useful.
- Zod for validating untrusted input and shared contracts.
- MySQL 8 with mysql2 and Drizzle ORM for relational persistence.
- Redis only when justified by a concrete requirement such as shared sessions, caching, rate limiting, or coordination.
- Vitest for unit/integration tests and Playwright for browser-level tests.
- Docker Compose for local dependencies when it simplifies onboarding.
- GitHub Actions for CI when GitHub Actions is the repository's CI platform.

Do not assume these are already installed or that the latest versions are compatible. Inspect lockfiles and official project documentation where available. Preserve an existing stack unless migration is explicitly requested.

## Workflow

### 1. Discover and plan

1. Inspect the repository, existing instructions, package manager, lockfile, CI, deployment configuration, and current application structure.
2. Clarify the business domain, primary users, roles, core workflows, data entities, external integrations, authentication requirements, and deployment target.
3. Identify assumptions and meaningful architectural decisions. Ask questions only when an unknown blocks a safe or useful implementation; otherwise document reasonable assumptions.
4. Propose a small implementation plan with a vertical slice and acceptance criteria.

### 2. Establish the foundation

1. Create or adapt the Nuxt application using the repository's conventions.
2. Configure TypeScript strictness, linting/formatting where applicable, environment validation, and useful package scripts.
3. Organize modules by responsibility without overengineering. A possible starting point is:
   - `app/`: pages, layouts, components, composables, UI state.
   - `server/api/`: HTTP endpoints and transport-level validation.
   - `server/services/`: application use cases and business workflows.
   - `server/repositories/`: persistence access.
   - `server/utils/`: server-only infrastructure utilities.
   - `shared/`: contracts and schemas safe to share with the client.
   - `database/`: migrations and database setup.
   - `tests/`: unit, integration, and end-to-end tests.
4. Keep server-only modules and secrets out of client bundles.
5. Select SPA rendering only when it fits the application. Consider SSR when SEO, public pages, or first-render requirements justify it.

### 3. Implement one complete vertical slice

1. Select one representative business workflow.
2. Define its input/output contracts and validation rules.
3. Implement the UI, server endpoint, application logic, persistence, and error handling.
4. Add loading, empty, success, and failure states to the UI.
5. Add tests for the important business behavior and failure paths.
6. Verify the flow end to end before generating additional screens or modules.

### 4. Persistence and infrastructure

- Use migrations as the source of truth for schema evolution.
- Keep database credentials in environment variables or a secret manager.
- Use parameterized queries or safe ORM APIs.
- Make local dependencies reproducible and document startup, migration, and reset commands.
- Add Redis only for a documented need. Define TTL, failure behavior, and invalidation where relevant.
- Add health checks that distinguish process liveness from dependency readiness when useful.
- Never run destructive migrations or reset user data without explicit authorization.

### 5. Authentication and authorization

- Confirm whether authentication is required and whether the application uses an identity provider, application-managed sessions, or another established model.
- Enforce authorization server-side for each protected operation.
- If using cookie sessions, use opaque, revocable session identifiers and appropriate HttpOnly, Secure, and SameSite attributes.
- Consider CSRF protection for cookie-authenticated state-changing requests.
- Do not introduce custom password hashing, token formats, or cryptography when established libraries and identity providers are suitable.
- Never copy insecure legacy patterns simply because they exist in an example project.

### 6. Quality and delivery

1. Run the relevant type check, lint, tests, and production build.
2. Fix regressions introduced by the changes.
3. Inspect the diff for secrets, generated files, unrelated edits, and accidental configuration changes.
4. Document setup, environment variables, migrations, tests, architectural assumptions, and known limitations.
5. Report checks actually executed and any remaining work.

## Definition of done

- The app starts using documented local instructions.
- Required environment variables are documented and validated safely.
- The implemented vertical slice works across UI, server, and persistence where applicable.
- Relevant automated tests exist and executed checks are reported honestly.
- No secrets are committed.
- Database schema changes are represented by migrations.
- Errors and authorization are handled at the appropriate boundaries.
- The README explains setup, configuration, test commands, and limitations.

## Avoid

- Generating every screen before validating a real workflow.
- Creating unnecessary abstractions, generic frameworks, or speculative microservices.
- Adding Redis, authentication, SSR, or other infrastructure without a requirement.
- Copying secrets, business data, or insecure implementation details from sample projects.
- Claiming tests, builds, migrations, or deployments succeeded without evidence.
