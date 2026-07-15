# notifications

In-app notifications, tenant preferences và realtime delivery.
Dùng cho HITL alerts, run completion và domain fan-out.

## Layout

| Path | Ownership |
|---|---|
| `domain/` | Notification/preference aggregates |
| `application/` | Inbox commands/queries + events |
| `agent-tools/` | Optional notify tools (effect `write_*` → approval) |
| `tests/` | unit / contract / integration |

## Không sở hữu

Transport wiring trong apps, audit system of record.
