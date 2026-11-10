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

General-purpose agents that collaborate under a single human-facing coordinator:

- **[Coordinator](agents/coordinator/AGENTS.md)**: sole human interface, decision authority, delegation, escalation, Definition of Ready and Definition of Done.
- **[Implementer](agents/implementer/AGENTS.md)**: simple, maintainable, framework-idiomatic implementation with tests and documentation.
- **[Quality](agents/quality/AGENTS.md)**: decision tables, Boolean conditions, risk-based scenarios and independent regression verification. [Scenario matrix](agents/quality/artifacts/scenario-matrix.md).

Workflow: **refine acceptance criteria → Quality designs scenarios → Implementer builds and tests → Quality verifies → Coordinator accepts or returns**. Ambiguous acceptance criteria block implementation. The coordinator may invoke any other agent available in the mission context.

## Shared principles

- Evidence before assumptions.
- Deterministic work before LLM reasoning when practical.
- Preserve uncertainty instead of manufacturing certainty.
- Human decisions become durable project knowledge.
- Measure product outcomes, not output volume.
