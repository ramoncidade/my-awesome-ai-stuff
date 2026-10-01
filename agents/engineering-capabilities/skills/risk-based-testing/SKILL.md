---
name: risk-based-testing
description: Derive a test strategy from requirements, failure modes and impact.
artifact_type: skill
version: 1.0.0
status: draft
---

# Risk-Based Testing

## Procedure
1. Identify critical business behaviors and failure consequences.
2. Map requirements and acceptance criteria to observable outcomes.
3. Select the lowest test level that provides meaningful confidence.
4. Cover positive, negative, boundary and failure scenarios.
5. Include authorization, duplicate delivery, timeout, retry and recovery where relevant.
6. Keep tests deterministic and isolate external dependencies.
7. Report untested risks and distinguish test execution from test design.

## Output
Requirement-to-test matrix, prioritized cases, execution levels and known gaps.

## Safety
Never weaken assertions or remove important tests merely to obtain a green pipeline. Never claim tests passed unless they were actually run.
