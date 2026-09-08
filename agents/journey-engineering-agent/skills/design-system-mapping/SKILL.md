# Skill: Design System Mapping

## Purpose
Translate design evidence into canonical Design System usage instead of recreating components ad hoc.

## Inputs
- Figma components and variants.
- Design System documentation.
- Design System source code or component registry.
- Existing web implementation conventions.

## Mapping chain

`Figma component -> Design System component -> implementation component/API`

## Rules

1. Prefer canonical Design System components over custom implementations.
2. Preserve variant, size, state and semantic intent.
3. Distinguish visual similarity from semantic equivalence.
4. Record unknown mappings instead of guessing.
5. Identify missing Design System capabilities explicitly.
6. Capture usage restrictions and accessibility requirements when documented.

## Required output

```yaml
mapping:
  figma_component: <name>
  design_system_component: <name|null>
  implementation_reference: <reference|null>
  confidence: high|medium|low
  rationale: <why>
  evidence: []
  open_questions: []
```

Update `artifacts/design-system-map.yaml`.
