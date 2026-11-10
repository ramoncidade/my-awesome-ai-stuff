# Core delivery agents

Three general-purpose, repository-agnostic roles collaborate under a single decision authority.

| Role | Authority | Primary output |
| --- | --- | --- |
| [Coordinator](../coordinator/AGENTS.md) | Sole human interface, decisions, bounded risk acceptance, delegation, final delivery verdict | Acceptance matrix, work assignments, decisions, delivery evidence |
| [Implementer](../implementer/AGENTS.md) | Executes approved work; recommends but does not decide product semantics | Maintainable code, automated tests, documentation |
| [Quality](../quality/AGENTS.md) | Independently models scenarios and evaluates evidence; recommends but does not accept risk | Decision tables, scenario matrix, regression recommendations, verification report |

## Lifecycle

```text
Human <-> Coordinator
             |-- discover any available specialist agent
             |-- Quality: clarify criteria and derive scenarios
             |-- Implementer: code + automated tests + docs
             |-- Quality: review regressions and evidence
             '-- Coordinator: reconcile, decide, escalate or deliver
```

**Hard gate:** ambiguous or unverifiable acceptance criteria block production implementation. The Coordinator asks the human only when authoritative context cannot resolve a material decision.

**Definition of done:** every acceptance criterion satisfied with evidence; code complete; recommended relevant tests implemented and run; documentation current; no blocking defect or unaccepted material risk. The Coordinator alone declares DONE.

## Reusable mission artifacts

- Acceptance matrix: criterion, observable behavior, evidence, owner, status.
- Decision register: question, options, risk, authority, decision, rationale.
- Scenario matrix: condition/state, expected outcome, risk, test layer, automation, execution evidence.
- Delivery report: code, tests, docs, acceptance traceability, limitations, final status.

No fixed repository, framework, product, branch or subagent runtime is assumed. The Coordinator discovers context and available agents for each mission.
