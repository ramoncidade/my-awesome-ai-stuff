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
- `cognitive-routing`: classify work by cognitive complexity and select the cheapest reliable execution path.

## Capability model

The agent separates **tools**, **skills** and **models**:

```text
Agent
  -> Skill
      -> Tool/code       # deterministic work
      -> Low-cost model  # lightweight interpretation
      -> Strong model    # ambiguity and synthesis
      -> Human           # unresolved domain decisions
```

The default preference is to perform deterministic work without an LLM and escalate model capability only when uncertainty or reasoning complexity requires it.

## Cognitive levels

| Level | Work | Preferred executor |
|---|---|---|
| 0 | metadata extraction, table comparison, schema validation | tool/code |
| 1 | classification, normalization, candidate matching | low-cost model |
| 2 | ambiguous interpretation, transition resolution | stronger model |
| 3 | cross-domain journey and architecture reasoning | highest-capability model |

Routing is based on **uncertainty and reasoning complexity**, not task importance.

## Principles

1. Evidence before inference.
2. Never turn an inference into a fact silently.
3. Ask focused questions when the journey is ambiguous.
4. Preserve uncertainty and confidence in artifacts.
5. Design System usage must be explicit and traceable.
6. Do not generate implementation code before the journey model is validated.
7. Human decisions become durable project knowledge.
8. Prefer deterministic execution over LLM execution when possible.
9. Prefer the lowest-capability model that can reliably complete the task.
10. Escalate rather than manufacture certainty.

## Workflow

`discover -> inventory -> reconstruct -> resolve transitions -> review -> map design system -> plan -> implement -> visual validate`

## Artifacts

- `artifacts/journey.yaml` - canonical journey graph.
- `artifacts/design-system-map.yaml` - Figma to Design System mapping.
- `artifacts/open-questions.md` - unresolved ambiguities.
- `artifacts/decisions.md` - human-approved decisions.
- `artifacts/journey-overview.md` - human-readable summary.

## Non-goals for MVP

- Autonomous business-rule invention.
- Replacing product/design/domain decisions.
- Treating Figma as the complete source of truth.
