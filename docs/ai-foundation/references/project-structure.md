# Suggested Nuxt Project Structure

Adapt this structure to the application's size and the conventions already in place. Do not create empty directories for hypothetical future features.

```text
app/
  components/
  composables/
  layouts/
  middleware/
  pages/
  plugins/
  assets/
server/
  api/
  middleware/
  services/
  repositories/
  utils/
shared/
  schemas/
  contracts/
database/
  migrations/
tests/
  unit/
  integration/
  e2e/
```

## Responsibility boundaries

- `app/`: client-facing UI, navigation, presentation state, and user interactions.
- `server/api/`: HTTP routing, request parsing, authentication context, schema validation, and response mapping.
- `server/services/`: application use cases and business workflows.
- `server/repositories/`: persistence access and database-specific queries.
- `server/utils/`: server-only technical utilities and infrastructure adapters.
- `shared/`: contracts and schemas safe to import from both client and server. Never put secrets or server-only modules here.
- `database/migrations/`: versioned, reviewable schema changes.
- `tests/`: tests grouped by scope and execution cost.

## Practical guidance

- Keep endpoints thin, but do not create a service/repository layer for every trivial operation without a reason.
- Keep business rules testable without requiring a running web server where practical.
- Do not import server-only modules into client components.
- Avoid a generic base repository unless it materially reduces duplication without hiding important query behavior.
- Organize larger domains by feature when that improves cohesion; the structure above is a starting point, not a rigid architecture.
