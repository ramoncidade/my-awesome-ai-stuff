# Skill: Visual Validation

## Purpose
Compare an implemented web screen against its Figma reference and produce actionable, structured fidelity findings.

## Principle

Visual validation is a separate concern from journey reconstruction. The validator checks whether implementation respects the intended visual specification and Design System mapping.

## Inputs

- Figma reference node/frame.
- Rendered implementation screenshot or equivalent visual artifact.
- Design System mapping when available.
- Viewport dimensions.

## Validation dimensions

Evaluate independently:

- structure
- layout and alignment
- spacing
- typography
- colors
- sizing
- component identity
- component variants and states
- imagery and icons
- responsive behavior when applicable

## Output

```yaml
validation:
  screen: <screen-id>
  reference:
    figma_node: <reference>
    viewport: <width>x<height>
  result: pass|needs-fix
  findings:
    - id: V-001
      category: spacing
      severity: critical|major|minor
      expected: <expected behavior>
      actual: <observed implementation>
      evidence: <reference or measurement>
      suggested_action: <action>
  summary:
    structural_fidelity: high|medium|low
    visual_fidelity: high|medium|low
    design_system_fidelity: high|medium|low
```

## Rules

1. Do not reduce validation to a single similarity score.
2. Prefer measurable differences over subjective language.
3. Distinguish implementation defects from ambiguous Figma specifications.
4. When a mismatch indicates an incorrect Design System mapping, link the finding to the relevant mapping artifact.
5. Do not silently change the journey model based on visual differences.
6. Re-run validation after material corrections.
