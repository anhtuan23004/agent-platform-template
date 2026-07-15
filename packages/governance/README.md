# governance

Policy evaluation, permissions bridge, HITL checkpoints và execution budgets.
Security/risk boundary trước khi tool chạy.

## Layout

```text
src/     # Policy engine, approval flow, budget guards
tests/   # Policy fixtures, HITL lifecycle
```

## Public surface (planned)

| Entry | Purpose |
|---|---|
| `governance` | Evaluate risk, require approval, enforce budgets |
| `governance/hitl` | Durable interrupt/resume với approval record |
| `governance/testing` | Policy fixtures |

## Không sở hữu

Prompt-only enforcement, tool implementation, domain mutations.

Xem [HITL & guardrails](../../docs/architecture/hitl-guardrails.md).
