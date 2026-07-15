# Documentation Map

```text
docs/
├── architecture/     # Thiết kế AI Agent doanh nghiệp
├── harness/          # Operating model cho từng change
├── product/          # Product contract (khi có spec nghiệp vụ)
├── stories/          # Epic / story / spike / task packets
└── templates/        # Harness packet formats
```

Form templates kiến trúc (tool-spec, solution-design, …): root
[`templates/`](../templates/).

## Architecture

Bắt đầu từ [`architecture/index.md`](architecture/index.md).

| Doc | Mục đích |
|---|---|
| `architecture/overview.md` | Capability map và vòng thực thi |
| `architecture/boundaries.md` | Dependency, contracts, ports |
| `architecture/memory.md` … `hitl-guardrails.md` | Capability chi tiết |
| `architecture/security-deployment.md` | Ops & security / UAT topology |
| `architecture/ARCHITECTURE.md` | Boundary summary cho Harness context rules |

## Harness

| Doc | Mục đích |
|---|---|
| `harness/HARNESS.md` | Operating loop và done definition |
| `harness/FEATURE_INTAKE.md` | Request types + risk lanes |
| `harness/CONTEXT_RULES.md` | Đọc gì theo phase/lane |
| `harness/TEST_MATRIX.md` | Proof semantics (`harness-cli query matrix`) |
| `harness/TRACE_SPEC.md` | Trace quality |

## Current State

Architecture skeleton + UAT infra + Harness v0. App runtime code chưa có —
implementation đi qua intake/story trước.
