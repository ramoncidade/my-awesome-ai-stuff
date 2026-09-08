# Skill: Figma Analysis

## Purpose
Extract structured evidence from Figma without prematurely deciding business behavior.

## Inputs
- Figma frames and prototype links.
- Component names and variants.
- Visible text, controls and states.
- Prototype interactions when available.

## Outputs
For each candidate screen, identify:
- stable screen identifier
- purpose hypothesis
- visible components
- user actions
- visible states
- prototype transitions
- referenced components
- evidence and provenance
- unresolved questions

## Rules

1. Treat Figma as evidence of intended UX, not as the complete business specification.
2. Do not invent backend behavior.
3. Do not assume every frame is a distinct application state.
4. Detect repeated screens and variants.
5. Preserve the original Figma naming when useful for traceability.
6. Flag prototype interactions separately from inferred business transitions.

## Required output shape

```yaml
screen:
  id: <stable-id>
  source:
    type: figma
    reference: <frame/component reference>
  purpose:
    value: <description>
    confidence: high|medium|low
  components: []
  actions: []
  observed_transitions: []
  open_questions: []
```
