# Skill: Cognitive Routing

## Purpose
Route each unit of work to the cheapest reliable executor: deterministic tool/code, low-cost model, stronger model, or human review.

## Core principle

> Never use an LLM when a deterministic operation can produce the required result.

> Never use a high-capability model when a lower-capability model can reliably produce the required result.

Escalate based on uncertainty and reasoning complexity, not task importance.

## Execution levels

### Level 0 - Deterministic

Use tools or code.

Examples:
- read Figma metadata
- traverse nodes
- query MCP resources
- compare structured tables
- validate schemas
- calculate visual dimensions
- perform exact component/name lookup

### Level 1 - Mechanical interpretation

Use a low-cost model when lightweight interpretation is needed.

Examples:
- classify a component
- normalize names
- summarize metadata
- rank likely Design System candidates

### Level 2 - Ambiguous reasoning

Use a stronger model when alternatives must be evaluated.

Examples:
- resolve an uncertain transition
- distinguish screen from state
- determine semantic component equivalence
- reconcile conflicting evidence

### Level 3 - Cross-domain reasoning

Use the highest-capability model available when synthesis spans multiple domains.

Examples:
- reconstruct a complex journey
- reason about missing screens
- validate journey consistency
- derive architecture implications

## Routing contract

Every routed task should produce:

```yaml
task:
  type: <task-type>
  complexity:
    operational: low|medium|high
    ambiguity: none|low|medium|high
    cross_domain_reasoning: false|true

routing:
  level: 0|1|2|3
  executor: tool|cheap-model|strong-model|human
  escalation_allowed: true|false

confidence:
  value: 0.0
  qualitative: high|medium|low
```

## Escalation guidance

- Deterministic operation available -> execute it directly.
- Confidence >= 0.90 from low-cost interpretation -> accept when validation rules permit.
- Confidence 0.70-0.90 -> escalate for material decisions.
- Confidence < 0.70 -> escalate or ask the human.
- Critical unresolved domain decision -> ask the human rather than inventing an answer.

Numeric confidence is a routing signal, not proof of correctness.

## Anti-patterns

Do not route a simple MCP read to an advanced model.
Do not ask a low-cost model to make an irreversible domain decision.
Do not use a similarity score as a substitute for semantic validation.
Do not hide uncertainty by converting a candidate into a fact.
