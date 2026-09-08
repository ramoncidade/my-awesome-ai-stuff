# Journey Engineering Agent

Agent for reconstructing and planning digital journeys from design artifacts, existing systems and human validation.

## Goal

Transform a collection of Figma screens into a validated journey model before implementation.

The agent must not jump directly from Figma to code. The canonical intermediate artifact is the **Journey Model**.

## MVP skills

- `figma-analysis`: extract observable evidence from Figma.
- `journey-modeling`: reconstruct screens, states, actions and transitions.
- `design-system-mapping`: map Figma components to the available Design System.
- `journey-review`: conduct structured human validation and record decisions.

## Principles

1. Evidence before inference.
2. Never turn an inference into a fact silently.
3. Ask focused questions when the journey is ambiguous.
4. Preserve uncertainty and confidence in artifacts.
5. Design System usage must be explicit and traceable.
6. Do not generate implementation code before the journey model is validated.
7. Human decisions become durable project knowledge.

## Workflow

`discover -> inventory -> reconstruct -> review -> map design system -> map backend -> plan -> implement`

## Artifacts

- `artifacts/journey.yaml` - canonical journey graph.
- `artifacts/design-system-map.yaml` - Figma to Design System mapping.
- `artifacts/open-questions.md` - unresolved ambiguities.
- `artifacts/decisions.md` - human-approved decisions.
- `artifacts/journey-overview.md` - human-readable summary.

## Non-goals for MVP

- Automatic code generation.
- Autonomous business-rule invention.
- Replacing product/design/domain decisions.
