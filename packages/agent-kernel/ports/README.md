# agent-kernel/ports

Dependency-inversion boundaries. Adapters implement; application consume.
Ports không import adapters/frameworks.

## Ports dự kiến

| Port | Vai trò |
|---|---|
| `ChatRuntime` | invoke/stream/cancel với canonical events |
| `WorkflowRuntime` | start/resume/status/cancel qua `ExecutionRef` |
| `CheckpointStore` | save/load/list/delete, tenant-scoped |
| `MemoryStore` | search/upsert/delete + policy metadata |
| `ApprovalStore` | durable HITL decisions |
| `AuditPort` | immutable audit/outbox emission |
| `ToolDispatcher` | authorize + invoke tool closures |
