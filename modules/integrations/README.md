# integrations

External connectors — credential storage, provider APIs, sync jobs.
Secrets at rest dùng `packages/shared-crypto`.

## Layout

| Path | Ownership |
|---|---|
| `domain/` | Credential/connector aggregates, sync rules |
| `application/` | Credential/connector commands + events |
| `agent-tools/` | Narrow read/status tools; write/sync qua HITL |
| `tests/` | unit / contract / integration |

## Không sở hữu

Envelope crypto implementation, mail transport primitives, runtime scheduling.
