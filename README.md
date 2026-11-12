# my-awesome-ai-stuff

A laboratory for reusable AI agents, skills and agentic engineering patterns.

## Agents

### Journey Engineering Agent

Reconstructs and plans complex digital journeys from Figma and other engineering evidence. Uses a canonical **Journey Model** between design and implementation.

- [Agent instructions](agents/journey-engineering-agent/AGENTS.md)
- [Agent overview](agents/journey-engineering-agent/README.md)

### UX Product Engineer

General-purpose agent for incrementally evolving existing digital products, without a fixed repository, product, technology stack or documentation path. Focuses on task efficiency, operational clarity, error prevention, accessibility and implementation quality.

- [Agent instructions](agents/ux-product-engineer/AGENTS.md)
- [Agent overview](agents/ux-product-engineer/README.md)
- [Issue template](agents/ux-product-engineer/artifacts/issue-template.md)
- [Friction register template](agents/ux-product-engineer/artifacts/friction-register.md)


### Execution triad

General-purpose agents that collaborate under a single human-facing coordinator. See the [shared delivery workflow](agents/core-delivery/README.md).


- **[Coordinator](agents/coordinator/AGENTS.md)** ([overview](agents/coordinator/README.md)): sole human interface, bounded decision authority, delegation, escalation and delivery accountability.
- **[Implementer](agents/implementer/AGENTS.md)** ([overview](agents/implementer/README.md)): simple, maintainable, framework-idiomatic implementation with tests and documentation.
- **[Quality](agents/quality/AGENTS.md)** ([overview](agents/quality/README.md)): Boolean decision modeling, risk-based scenarios, test design and independent regression verification. [Scenario matrix](agents/quality/artifacts/scenario-matrix.md).

Workflow: **refine acceptance criteria → Quality designs scenarios → Implementer builds and tests → Quality verifies → Coordinator accepts or returns**. Ambiguous acceptance criteria block implementation. The coordinator may invoke any other agent available in the mission context.

### Vue Platform Engineer

Especialista generalista em Vue.js e seu ecossistema. Descobre a stack real de cada repositório antes de recomendar padrões ou implementar mudanças.

- [Agent instructions](agents/vue-platform-engineer/AGENTS.md)
- [Agent overview](agents/vue-platform-engineer/README.md)
- [Stack discovery template](agents/vue-platform-engineer/artifacts/stack-discovery.md)

## Shared principles

- Evidence before assumptions.
- Deterministic work before LLM reasoning when practical.
- Preserve uncertainty instead of manufacturing certainty.
- Human decisions become durable project knowledge.
- Measure product outcomes, not output volume.
