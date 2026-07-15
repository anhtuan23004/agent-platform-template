# Tool orchestration

[← Mục lục](index.md)

Tool orchestration là security boundary nơi AI chạm nghiệp vụ. Model có thể đề xuất tool call;
dispatcher mới có quyền quyết định tool có được chạy hay không.

## Luồng dispatch

1. Resolve tool từ allowlist theo agent/version; không nhận arbitrary function name.
2. Validate input bằng schema strict và giới hạn kích thước.
3. Re-check tenant, permission, resource scope và purpose.
4. Áp dụng effect/risk policy, rate limit, timeout và approval checkpoint.
5. Tạo idempotency key; thực thi qua public domain surface hoặc isolated adapter.
6. Validate/sanitize output; trả structured result, không đẩy raw secret vào model.
7. Ghi lifecycle/audit event với correlation và latency.

## Effect classification

| Effect | Ví dụ | Default control |
|---|---|---|
| `read` | Search, fetch record | Permission + logging |
| `write_reversible` | Draft/update có history | Approval theo risk + idempotency |
| `write_irreversible` | Send message, payment | Explicit approval + narrow scope |
| `external_execution` | Code/shell/browser | Sandbox, egress allowlist, quotas, approval |

## Tool contract checklist

- Mục đích hẹp; tên/mô tả không mơ hồ.
- Typed input/output, schema version và deterministic validation.
- Required permission, tenant/resource scoping và data classification.
- Effect, risk tier, approval policy và execution boundary.
- Timeout, retry semantics, concurrency/rate limit.
- Idempotency scope, deduplication window và reconciliation endpoint.
- Audit fields, redaction và metrics.
- Compensation/manual recovery cho partial side effect.

Không đặt authorization chỉ trong prompt hay tool description. Domain callee phải re-check.
Điền [Tool specification](../../templates/tool-spec.template.yaml) trước khi đăng ký tool.

