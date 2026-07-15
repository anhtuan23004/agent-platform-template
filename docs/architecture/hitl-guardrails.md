# Human-in-the-loop và guardrails

[← Mục lục](index.md)

## Khi phải dừng cho con người

- Write tool theo policy, đặc biệt financial, legal, identity hoặc external communication.
- Confidence dưới threshold hoặc evidence mâu thuẫn.
- Scope/chi phí vượt budget được phê duyệt.
- Model đề xuất thay đổi plan làm tăng risk.
- Dữ liệu nhạy cảm cần purpose/consent mới.
- Exception không có deterministic recovery.

## Approval record

Checkpoint phải durable và chứa: actor/requester, approver policy, proposed action, sanitized
parameters, expected effect, evidence, risk, expiry, decision, reason, timestamps và immutable
correlation IDs. Client chỉ gửi decision; server resolve và authorize execution reference.

## Decision semantics

- **Approve once:** chỉ cho đúng action hash và idempotency key.
- **Edit and approve:** tạo action proposal mới, validate lại và audit cả hai phiên bản.
- **Reject:** terminal hoặc quay lại node được định nghĩa trước; không tự đổi phrasing để thử lại.
- **Expire/cancel:** không thực thi action; checkpoint có terminal reason.
- **Delegate:** approver mới phải thỏa policy, không chỉ được requester chỉ định.

## Guardrail layers

1. Input: authentication, content size, malware/DLP, prompt-injection signals.
2. Planning: allowlist, budgets, confidence và maximum steps.
3. Pre-tool: schema, permission, approval, rate limit và sandbox.
4. Post-tool: output validation, redaction, reconciliation và audit.
5. Response: policy filters, citation/provenance, no-secret leakage.

Guardrails không bảo đảm model luôn đúng; chúng thu hẹp blast radius và tạo evidence để phục
hồi. Dùng [HITL policy template](../../templates/hitl-policy.template.yaml).

