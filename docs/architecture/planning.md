# Planning architecture

[← Mục lục](index.md)

## Chọn loại planning

| Tình huống | Cơ chế | Ví dụ |
|---|---|---|
| Quy trình regulated, thứ tự cố định | Deterministic state machine | Procurement approval, onboarding |
| Có nhánh rõ nhưng cần model phân loại | Graph + bounded model node | Incident triage, document intake |
| Mục tiêu mở, read-only exploration | Adaptive tool loop | Research, knowledge assistant |
| Write nhiều bước hoặc irreversible | Graph + explicit HITL | Payment, account changes |

Đừng dùng adaptive loop nếu workflow có thể mô tả bằng state machine đơn giản. Model chỉ nên
xử lý phần bất định; transition, calculation và approval rule nên deterministic.

## Plan contract

Mỗi plan cần: goal, preconditions, state schema, steps, transition conditions, allowed tools,
budgets, checkpoints, terminal states, retry và compensation. Persist plan version/hash cùng run
để có thể giải thích quyết định sau này.

## Execution invariants

- `max_steps`, deadline, model/tool budget và recursion limit luôn hữu hạn.
- Mỗi step khai báo read/write effect và retry policy.
- Transition chỉ dựa trên validated state; model output phải schema-validate.
- Pause/resume không lặp side effect: dùng idempotency key theo run/step/attempt.
- Re-plan chỉ trong boundary được phép; thay đổi scope/risk phải escalation.
- Terminal state gồm `completed`, `failed`, `cancelled`, `expired`, không chỉ success/error.

## Failure strategy

| Failure | Default response |
|---|---|
| Model timeout/invalid output | Bounded retry, fallback model hoặc escalate |
| Read tool transient error | Exponential backoff trong deadline |
| Write uncertainty | Không retry mù; reconcile bằng idempotency key |
| Approval expired/rejected | Expire/cancel nhánh; audit decision |
| Worker crash | Resume từ durable checkpoint |
| External partial success | Compensation hoặc manual recovery runbook |

Xem [Workflow/plan template](../../templates/workflow-plan.template.yaml).

