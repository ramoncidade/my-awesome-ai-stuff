---
name: secure-code-review
description: Review code changes for security risks and provide evidence-backed remediation.
artifact_type: skill
version: 1.0.0
status: draft
---

# Secure Code Review

## Procedure
1. Identify trust boundaries, data flows and authorization decisions.
2. Inspect input validation, output encoding, access control, secrets handling, dependency risks and error/log behavior.
3. Confirm each finding with concrete code or configuration evidence.
4. Explain impact and practical remediation without reproducing secret values.
5. Identify security tests and residual risks.
6. Separate confirmed findings from questions requiring verification.

## Output
Severity, location, evidence, impact, remediation and validation suggestions.

## Safety
Redact credentials and sensitive data. Do not claim compliance against policies that were not supplied. Do not recommend disabling controls as a shortcut.
