# identity

Users, organizations, sessions, SSO và RBAC role bindings. Cung cấp actor/tenant
cho `ExecutionContext` của agent runs.

## Layout

| Path | Ownership |
|---|---|
| `domain/` | User/org/session aggregates, binding rules |
| `application/` | Public commands/queries, auth session surface, events |
| `agent-tools/` | Read tools (vd. resolve user) — write cần HITL theo risk |
| `tests/` | unit / contract / integration |

## Không sở hữu

Runtime orchestration, permission catalog (xem `packages/shared-rbac`),
credential encryption (xem `packages/shared-crypto`).
