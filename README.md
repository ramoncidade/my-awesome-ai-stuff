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

## Shared principles

- Evidence before assumptions.
- Deterministic work before LLM reasoning when practical.
- Preserve uncertainty instead of manufacturing certainty.
- Human decisions become durable project knowledge.
- Measure product outcomes, not output volume.

### Core delivery agents

A general-purpose delivery trio with a single human-facing decision authority. The Coordinator delegates to any available specialist, the Implementer builds maintainable code/tests/docs, and Quality derives risk-based scenarios using Boolean decision modeling and other techniques. Ambiguous acceptance criteria block production implementation.

- [Core delivery workflow](agents/core-delivery/README.md)
- [Coordinator instructions](agents/coordinator/AGENTS.md)
- [Implementer instructions](agents/implementer/AGENTS.md)
- [Quality instructions](agents/quality/AGENTS.md)
