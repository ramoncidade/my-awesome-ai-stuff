# Skill: Journey Modeling

## Purpose
Transform isolated screen evidence into a coherent journey graph.

## Responsibilities
- Group frames into logical screens and states.
- Identify entry and exit conditions.
- Model user actions.
- Model transitions and branching.
- Link transitions to evidence, decisions or open questions.
- Detect unreachable, duplicated or ambiguous states.

## Core entities

`Journey`, `Screen`, `State`, `Action`, `Transition`, `Condition`, `BusinessRule`, `Dependency`, `Question`, `Decision`.

## Rules

1. A screen is not necessarily a state.
2. A transition must have a trigger.
3. Branching must be explicit.
4. Error, loading, empty and success states should be modeled when relevant.
5. Do not collapse materially different business states merely because their UI looks similar.
6. Mark inferred transitions as inferred until confirmed.

## Review questions

When ambiguity exists, ask questions such as:

- What causes this transition?
- Is this a new business state or only a visual variant?
- Which backend operation determines the branch?
- Can the user return to the previous state?
- What happens on timeout, rejection or retry?

## Output
Update `artifacts/journey.yaml` and `artifacts/open-questions.md`.
