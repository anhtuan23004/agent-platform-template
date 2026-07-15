# core

Transactional outbox, event envelope, dispatcher và worker jobs — spine dùng chung của
modular monolith. Mọi module emit event trong cùng transaction với state change; subscribers
nhận at-least-once delivery.


## Layout

```text
src/
  backend/     # Router primitives, middleware hooks
  events/      # Event catalog + emit helpers
  testing/     # Bus/outbox fixtures
tests/
  unit|contract|integration/
```

## Public surface (planned)

| Entry | Purpose |
|---|---|
| `core` | Registry, lifecycle, composition helpers |
| `core/events` | Event envelope + `emitInTransaction()`; module sở hữu business event schema |
| `core/outbox` | Outbox writer |
| `core/dispatcher` | Subscriber dispatch loop |
| `core/workers` | Background task registration |

## Dependency rule

`modules/*` được phép import duy nhất public surface `core/events` để emit event. `core`
không import module internals, không định nghĩa business event catalog và không chứa domain rule.
Queue primitive dùng từ `shared-orchestration`; run/workflow registry không nằm ở `core`.
