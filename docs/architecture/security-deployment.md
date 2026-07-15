# Security và deployment

[← Mục lục](index.md)

## Trust boundaries

- Client/channel ↔ API gateway.
- Agent runtime ↔ model provider.
- Agent/tool dispatcher ↔ domain/external services.
- Application ↔ checkpoint, memory, audit và domain stores.
- Tenant ↔ tenant trong mọi shared component.

Mọi dữ liệu từ user, retrieved document, model output và tool output đều untrusted cho đến khi
được schema/policy validate.

## Security controls

| Boundary | Controls tối thiểu |
|---|---|
| Identity | Strong auth, short-lived session, workload identity, step-up auth |
| Authorization | Tenant/resource scope, least privilege, callee re-check, deny by default |
| Model egress | Provider allowlist, DLP/redaction, regional routing, no training agreement |
| Tool execution | Allowlist, sandbox, egress policy, timeout, quotas, approval |
| Data stores | Encryption, tenant isolation, backups, PITR, deletion workflow |
| Secrets | Secret manager, rotation, no prompt/log/checkpoint secrets |
| Supply chain | Pinned lockfile/image digest, SBOM, scanning, signed artifacts |
| Operations | Break-glass with audit, separation of duties, incident runbooks |

## Deployment topology

### UAT (hiện tại)

Một Cloud Server trên FPT Cloud + Docker Compose (API/worker/postgres cùng host). Chi tiết:
[infra/fpt-cloud-uat](../../infra/fpt-cloud-uat/README.md). Đủ smoke/UAT; không phải HA.

### Production (deferred)

Tách stateless API/stream workers khỏi durable workflow workers nếu scaling/SLO khác nhau, nhưng
dùng cùng contracts và composition policy. Runtime cần graceful shutdown, checkpoint trước
termination, bounded concurrency, backpressure và dead-letter/manual recovery path.

Stores nên có ownership rõ: product DB, runtime checkpoint schema, memory/index và audit sink.
Có thể dùng chung một database vật lý nhưng không dùng chung table/client ownership. Backup và
restore phải kiểm thử consistency giữa source records và derived indexes.

## Production gates

- Threat model và data-flow review theo từng tool/provider.
- Load/soak test cho streaming, checkpoint contention và approval backlog.
- Chaos test worker crash, provider timeout, duplicate delivery và partial external success.
- Tenant isolation test ở query, cache, vector filter, logs và traces.
- RTO/RPO, rollback/roll-forward, key rotation và provider failover diễn tập được.
- Model/prompt/tool version được ghi cùng run; canary và kill switch theo agent/tool.

Điền [Threat model](../../templates/threat-model.template.md) và
[Rollout checklist](../../templates/rollout-checklist.template.md).

