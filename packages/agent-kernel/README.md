# agent-kernel

Lõi agent runtime-neutral: contracts, application use cases và ports.
Không phụ thuộc LangChain/LangGraph; runtime adapters implement ports.

## Layout

| Path | Ownership |
|---|---|
| `contracts/` | Pure DTO/schema — `ExecutionContext`, `AgentContract`, `ToolSpec`, stream events |
| `application/` | Use cases, lifecycle, budgets, orchestration policy |
| `ports/` | Interfaces: chat/workflow runtime, checkpoint, memory, approval, audit |

## Public surface (planned)

| Entry | Purpose |
|---|---|
| `agent-kernel/contracts` | Canonical types crossing app/runtime/channel |
| `agent-kernel/application` | Start/stream/cancel/resume use cases |
| `agent-kernel/ports` | Dependency-inversion boundaries |

## Không sở hữu

Runtime implementation, feature DB/domain internals, vendor stream types.
