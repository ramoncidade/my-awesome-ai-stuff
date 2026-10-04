# Nuxt Business Application Stack Reference

These are defaults for new business applications, inspired by a practical Nuxt stack. They are not requirements for every project.

| Concern | Default | Selection guidance |
|---|---|---|
| Runtime | Supported Node.js LTS | Pin a version compatible with the deployment platform |
| Web framework | Nuxt 3 + Vue 3 + TypeScript | Re-evaluate Nuxt major version and ecosystem compatibility when starting a new project |
| Backend endpoints | Nitro / H3 server routes | Use a separate backend when independent scaling, deployment, or domain boundaries justify it |
| UI components | PrimeVue 4 + PrimeIcons | Use an existing design system if one is already established |
| Input validation | Zod | Validate at server trust boundaries |
| Relational database | MySQL 8 | Choose based on existing platform and operational needs |
| Database access | mysql2 + Drizzle ORM | Use migrations and parameterized/safe query APIs |
| Cache/session store | Redis + ioredis | Add only when a concrete shared-state or performance need exists |
| Unit/integration tests | Vitest | Follow existing repository conventions |
| Browser tests | Playwright | Prioritize critical user journeys |
| Local infrastructure | Docker Compose | Use when it improves reproducibility |
| CI | GitHub Actions | Keep checks aligned with the repository's actual CI platform |

## Decisions to make explicitly

- SPA versus SSR, based on SEO, public pages, and rendering requirements.
- Authentication and authorization model.
- Session storage and CSRF controls when cookie authentication is used.
- Database, migration strategy, backup expectations, and transaction boundaries.
- Whether Redis is needed and what happens when it is unavailable.
- Observability, structured logging, metrics, tracing, and sensitive-field redaction.
- Deployment platform, health checks, environment configuration, and secret management.

## Version discipline

Do not blindly copy version numbers from examples. Inspect the project's lockfile and runtime constraints, confirm compatibility, and document intentional pins. Do not upgrade an existing application as an incidental part of scaffolding.
