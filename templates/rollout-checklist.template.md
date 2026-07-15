# Template — Rollout Checklist

> **TEMPLATE.** Đây là checklist review, không phải deployment script. Thay `{{...}}`.

[Lộ trình triển khai](../docs/architecture/implementation-roadmap.md)

## Ownership và scope

- [ ] Use case, tenants/users, owner và human accountability: `{{DETAILS}}`
- [ ] Risk tier, prohibited actions và blast radius được phê duyệt.
- [ ] Baseline, KPI, SLI/SLO và observation window: `{{THRESHOLDS}}`

## Architecture và data

- [ ] Contracts/ports không lộ vendor types; system-of-record ownership rõ.
- [ ] Tool, memory, workflow, HITL và audit templates đã review.
- [ ] Tenant isolation, classification, consent, retention, export/delete đã test.
- [ ] Runtime checkpoints tách product/business records.

## Safety và reliability

- [ ] Step/time/token/cost/rate/concurrency budgets được enforce.
- [ ] Write tools có approval, idempotency, reconciliation và compensation/runbook.
- [ ] Crash/resume, timeout, duplicate delivery, rejected/expired approval đã test.
- [ ] Prompt injection, tool-output injection, data exfiltration và permission bypass đã test.
- [ ] Kill switch theo agent/tool/tenant và emergency owner: `{{OWNER}}`.

## Quality và operations

- [ ] Offline eval, adversarial set và acceptance thresholds đạt: `{{RESULT_REFERENCE}}`.
- [ ] Load/soak/chaos tests đạt; capacity và cost guardrails xác nhận.
- [ ] Traces, metrics, alerts, immutable audit và dashboards hoạt động.
- [ ] On-call, support, incident, reconciliation và data-correction runbooks đã diễn tập.
- [ ] Provider limits, DPA/residency, secrets rotation, backup/restore xác nhận.

## Rollout stages

- [ ] Internal dogfood: `{{DATE_SCOPE_EXIT_CRITERIA}}`
- [ ] Limited tenants: `{{DATE_SCOPE_EXIT_CRITERIA}}`
- [ ] Percentage canary: `{{DATE_PERCENT_EXIT_CRITERIA}}`
- [ ] General availability: `{{DATE_APPROVERS}}`

## Stop/rollback criteria

- `{{QUALITY_SAFETY_LATENCY_COST_OR_INCIDENT_THRESHOLD}}`
- Rollback/roll-forward approach: `{{APPROACH}}`
- Suspended runs and external side effects handling: `{{DRAIN_RECONCILE_PLAN}}`

## Sign-off

| Role | Name | Decision | Date |
|---|---|---|---|
| Product/domain | `{{NAME}}` | `{{GO_NO_GO}}` | `{{DATE}}` |
| Security/privacy | `{{NAME}}` | `{{GO_NO_GO}}` | `{{DATE}}` |
| Platform/operations | `{{NAME}}` | `{{GO_NO_GO}}` | `{{DATE}}` |
