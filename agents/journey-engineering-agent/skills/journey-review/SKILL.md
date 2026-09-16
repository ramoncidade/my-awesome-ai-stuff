# Skill: Journey Review

## Purpose
Turn human expertise into explicit, durable decisions that improve the journey model.

## Review protocol

1. Summarize what is known.
2. Show the smallest ambiguous section of the journey.
3. Ask one focused question.
4. Record the answer as a decision.
5. Update affected screens, transitions and assumptions.
6. Re-check downstream consistency.

## Question quality

Prefer:

> Does `Continue` call the simulation operation before entering `confirmation`?

Avoid:

> Can you explain how this screen works?

## Decision types

- `product`
- `ux`
- `business-rule`
- `technical`
- `integration`
- `design-system`

## Rules

- Never ask the human to repeat information already present in the artifacts.
- Do not bundle unrelated questions.
- Explain why an answer matters when the impact is non-obvious.
- Mark decisions as human-confirmed and preserve their source.
- When a decision invalidates previous assumptions, identify and update them.

## Outputs

Update:
- `artifacts/decisions.md`
- `artifacts/open-questions.md`
- `artifacts/journey.yaml`
- affected screen artifacts
