# Packages

Platform libraries cho AI Agent: kernel, runtime adapters, governance,
persistence, event spine và shared libs. **Không chứa business domain.**

Domain / capability có aggregate và public surface nằm ở [`modules/`](../modules/README.md).
Apps chỉ boot và compose.

## Nhóm

| Nhóm | Packages | Vai trò |
|---|---|---|
| Agent kernel | `agent-kernel`, `runtime-langchain`, `runtime-langgraph` | Contracts/ports và runtime adapters |
| Governance & state | `governance`, `persistence`, `core` | Policy, HITL, stores, outbox/events |
| Shared infrastructure | `shared-*` | Types, RBAC, DB, retrieval, crypto, queue primitives, testing |

## Dependency direction

```text
apps/{api,worker} → apps/composition → packages/* + modules/* public surfaces
runtime-* → agent-kernel/{ports,contracts}   (không import modules/*)
modules/* → contracts + shared-* + core/events (không import runtime-*)
shared-* → không phụ thuộc modules/runtime

`core/events` là exception có chủ đích: module sở hữu schema business event, còn `core`
cung cấp envelope/outbox/dispatch mechanism. Chi tiết enforceable nằm trong
[`config/architecture-policy.yaml`](../config/architecture-policy.yaml).
```

Chi tiết: [STRUCTURE.md](../STRUCTURE.md).
