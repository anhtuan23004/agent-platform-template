# Audit và observability

[← Mục lục](index.md)

Audit trả lời “ai/agent đã quyết định và làm gì”; observability trả lời “hệ thống đang chạy thế
nào”. Có thể correlate nhưng retention, quyền truy cập và tính bất biến khác nhau.

## Canonical event envelope

Mỗi event cần `event_id`, `event_type`, `occurred_at`, `tenant_id`, `actor`, `agent_id/version`,
`run_id`, `correlation_id`, `causation_id`, `resource`, `action`, `outcome`, policy/model/tool
metadata và redacted payload reference. Schema phải versioned và consumer idempotent.

## Event lifecycle đề xuất

- `run.started`, `plan.created`, `model.completed`
- `tool.proposed`, `approval.requested`, `approval.decided`
- `tool.started`, `tool.succeeded`, `tool.failed`, `tool.reconciled`
- `memory.read`, `memory.written`, `memory.deleted`
- `run.completed`, `run.failed`, `run.cancelled`, `run.expired`

Không log chain-of-thought. Lưu structured decision summary, inputs/outputs đã redact, policy
result, evidence references và model/tool identifiers đủ để điều tra.

## Telemetry

- Traces: một run là root span; model, retrieval, approval wait và tool là child span.
- Metrics: success rate, latency, token/cost, tool error, approval rate/time, resume rate,
  memory hit/leakage, policy denial và idempotency conflict.
- Logs: structured, correlation-aware, tenant-safe; secrets bị redact trước sink.
- Alerts: SLO burn, unusual tool/write volume, repeated denials, stuck checkpoints và audit lag.

## Audit integrity

Domain mutation và audit event nên atomic qua transactional outbox. Với external side effect,
ghi intent trước, outcome/reconciliation sau. Bảo vệ log bằng append-only/WORM tùy compliance,
separation of duties, retention hold và access audit.

Xem [Audit event template](../../templates/audit-event.template.yaml).

