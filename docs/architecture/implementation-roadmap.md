# Lộ trình triển khai

[← Mục lục](index.md)

Triển khai theo vertical slice có thể chứng minh end-to-end, không xây toàn bộ “agent platform”
trước use case đầu tiên.

Giữ ownership và dependency direction theo
[project structure](../../STRUCTURE.md).

## Giai đoạn 0 — Quyết định và baseline

- Chọn một use case hẹp, owner, risk tier và success metrics.
- Hoàn thành solution design, threat model, data classification và ADRs.
- Đo baseline của quy trình hiện tại: thời gian, lỗi, chi phí và escalation.
- Giữ only-required folders từ [project structure](../../STRUCTURE.md) và áp dụng
  [architecture policy](../../config/architecture-policy.yaml) trước source code đầu tiên.

**Exit:** boundaries, prohibited actions và human accountability được phê duyệt.

## Giai đoạn 1 — Read-only tracer bullet

- Pure contracts, execution context, canonical events và một read tool.
- Tenant/RBAC checks, audit trail, eval dataset và observability dashboard.
- Runtime adapter đầu tiên có budgets, timeout và kill switch.

**Exit:** không cross-tenant leakage; answers có provenance; SLO/eval đạt ngưỡng pilot.

## Giai đoạn 2 — Bounded planning và memory

- Một deterministic graph; durable checkpoint và crash/resume tests.
- Conversation state; long-term memory chỉ khi có consent/retention/deletion.
- Invalid output, timeout, duplicate delivery và stale memory tests.

**Exit:** resume không lặp side effect; deletion SLA và recovery runbook đã diễn tập.

## Giai đoạn 3 — Write tool + HITL

- Một reversible write với idempotency, approval và immutable audit.
- Rejection, edit-and-approve, expiry, cancel, reconciliation và compensation paths.
- Security review và red-team prompt/tool abuse cases.

**Exit:** không write ngoài approval scope; duplicate execution an toàn; audit reconstruct được.

## Giai đoạn 4 — Controlled rollout

- Internal dogfood → limited tenants → percentage canary → general availability.
- Compare baseline; monitor quality, cost, latency, denials và human override.
- Incident/rollback drill, support ownership và on-call handoff.

**Exit:** business KPI và reliability SLO ổn định trong observation window.

## Definition of done cho mỗi capability

- Contract + owner + data classification.
- Unit/contract/integration/security/evaluation tests.
- Metrics, alerts, audit event và dashboard.
- Failure, retry, reconciliation và manual recovery documented.
- Runbook, rollback/kill switch và operator training.
- ADR cho trade-off có tác động dài hạn.
