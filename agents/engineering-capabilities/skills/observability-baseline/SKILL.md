---
name: observability-baseline
description: Define safe, useful logs, metrics, traces and alerts for an engineering service.
artifact_type: skill
version: 1.0.0
status: draft
---

# Observability Baseline

## Procedure
1. Start from operational questions, SLOs and failure modes.
2. Define structured logs, correlation identifiers, metrics and trace boundaries.
3. Use stable, low-cardinality metric dimensions.
4. Redact secrets, tokens, personal data and sensitive payloads.
5. Define symptom-oriented alerts with actionable runbook links.
6. Specify sampling, retention and cost considerations.
7. Verify that telemetry helps diagnose failures without exposing sensitive information.

## Output
Instrumentation checklist, field conventions, metric definitions, trace boundaries and alert proposals.

## Safety
Never log credentials or full sensitive payloads. Avoid high-cardinality labels and unbounded telemetry costs.
