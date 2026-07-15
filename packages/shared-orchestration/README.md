# shared-orchestration

Queue và scheduler primitives dùng chung: enqueue/dequeue contract, backoff policy và deterministic
test fake. Đây là infrastructure leaf package, không phải agent/workflow engine.


## Public surface (planned)

| Entry | Purpose |
|---|---|
| `shared-orchestration` | Queue client, scheduler primitive, backoff helper |

## Không sở hữu

- Agent lifecycle hoặc planning — thuộc `agent-kernel/application`.
- Graph/checkpoint/interrupt — thuộc `runtime-langgraph`.
- Run registry/product state — thuộc `persistence`.
- Worker dispatch policy — thuộc `core`.
