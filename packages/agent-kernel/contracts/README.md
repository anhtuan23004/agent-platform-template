# agent-kernel/contracts

Pure DTO và schema — không vendor/framework types.

## Nội dung dự kiến

- `ExecutionContext` — tenant, actor, claims, locale, correlation, deadline
- `AgentContract` — purpose, I/O, allowlist tools, budgets, escalation
- `ToolSpec` — schema, effect, permission, approval, idempotency, timeout
- `AgentStreamEvent` — lifecycle, delta, tool, interrupt, error, final
- `ExecutionRef` — opaque run/checkpoint/interrupt identity
