---
name: resilient-http-client
description: Design HTTP clients with bounded timeouts, safe retry, resilience controls and telemetry.
artifact_type: skill
version: 1.0.0
status: draft
---

# Resilient HTTP Client

## Procedure
1. Identify protocol, contract, operation semantics, SLO and failure modes.
2. Configure explicit connection, response and pool-acquisition timeouts.
3. Retry only transient failures and only when operation semantics permit it; use bounded attempts and backoff with jitter.
4. Protect non-idempotent operations with idempotency mechanisms where supported.
5. Consider circuit breaker, concurrency limits, bulkheads and rate limits based on failure isolation needs.
6. Instrument latency, outcomes and retries with low-cardinality attributes.
7. Redact tokens, credentials and sensitive payloads from logs.
8. Test timeout, retry exhaustion, open-circuit behavior, recovery and cancellation.

## Output
Configuration, rationale, failure behavior, telemetry plan and test cases.

## Safety
Do not create retry storms, infinite retries or unsafe duplicate side effects. Do not assume a library's defaults are appropriate without verifying them.
