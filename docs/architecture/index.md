# Agent Flatform Template

Đây là bộ tài liệu độc lập để thiết kế AI Agent dùng trong doanh nghiệp. Nội dung tập trung
vào ranh giới kiến trúc, độ tin cậy và khả năng kiểm toán; không phụ thuộc model hay framework
cụ thể. LangChain/LangGraph là một adapter khả dụng, không phải domain contract.

> Phạm vi: tài liệu, biểu mẫu và non-executable filesystem skeleton. Repo không chứa runtime,
> mã nguồn, package manifest hay deployment config có thể triển khai trực tiếp.

## Cách sử dụng

1. Đọc [Tổng quan kiến trúc](overview.md) và chốt ranh giới trong
   [Module và dependency boundaries](boundaries.md).
2. Thiết kế lần lượt [Memory](memory.md), [Planning](planning.md),
   [Tool orchestration](tool-orchestration.md) và [HITL/guardrails](hitl-guardrails.md).
3. Chốt [Audit/observability](audit-observability.md),
   [Security/deployment](security-deployment.md) và mapping
   [LangChain/LangGraph](langchain-langgraph-mapping.md).
4. Điền các biểu mẫu, review theo [Lộ trình triển khai](implementation-roadmap.md), rồi chạy
   rollout checklist.

## Bộ tài liệu

| Chủ đề | Mục đích |
|---|---|
| [Tổng quan](overview.md) | Capability map, luồng quyết định và ownership |
| [Boundaries](boundaries.md) | Dependency rule, contracts, ports và adapters |
| [Memory](memory.md) | Short-term/long-term memory, retention và retrieval |
| [Planning](planning.md) | Deterministic workflow và adaptive planning |
| [Tool orchestration](tool-orchestration.md) | Permission, validation, idempotency và compensation |
| [HITL & guardrails](hitl-guardrails.md) | Approval, execution boundary và escalation |
| [Audit & observability](audit-observability.md) | Event model, trace, metrics và incident evidence |
| [LangChain/LangGraph](langchain-langgraph-mapping.md) | Mapping runtime-neutral sang framework adapter |
| [Security & deployment](security-deployment.md) | Threat controls, isolation và topology |
| [FPT Cloud UAT](../../infra/fpt-cloud-uat/README.md) | 1 Cloud Server + Compose — đủ UAT |
| [GitHub Actions](../../.github/CONTRIBUTING-CI.md) | CI/CD UAT (release/rollback/db-reset) |
| [Roadmap](implementation-roadmap.md) | Tracer-bullet delivery và exit criteria |

## Biểu mẫu

| Template | Khi dùng |
|---|---|
| [Solution design](../../templates/solution-design.template.md) | Chốt toàn bộ solution architecture |
| [Agent contract](../../templates/agent-contract.template.yaml) | Định nghĩa đầu vào, đầu ra và giới hạn agent |
| [Tool specification](../../templates/tool-spec.template.yaml) | Đăng ký tool và policy thực thi |
| [Memory policy](../../templates/memory-policy.template.yaml) | Chốt dữ liệu, consent, retention và deletion |
| [Workflow/plan](../../templates/workflow-plan.template.yaml) | Mô hình hóa state machine và recovery |
| [HITL policy](../../templates/hitl-policy.template.yaml) | Xác định checkpoint và approver |
| [Audit event](../../templates/audit-event.template.yaml) | Chuẩn hóa event kiểm toán |
| [Threat model](../../templates/threat-model.template.md) | Phân tích tài sản, trust boundary và abuse case |
| [Rollout checklist](../../templates/rollout-checklist.template.md) | Kiểm tra trước pilot/production |
| [Project structure](../../STRUCTURE.md) | Cây thư mục: ownership và dependency direction |
| [Architecture policy](../../config/architecture-policy.yaml) | Dependency rules làm input cho CI boundary lint |
| [Harness](../harness/HARNESS.md) | Operating model cho từng change (intake → proof → trace) |
| [Feature intake](../harness/FEATURE_INTAKE.md) | Phân loại request và risk lane |
| [Context rules](../harness/CONTEXT_RULES.md) | Context đọc theo phase/lane |

## Nguyên tắc không thỏa hiệp

- Runtime framework không phải system of record.
- Mọi access đều tenant-scoped; domain re-check quyền tại callee.
- Write tool cần approval theo risk, idempotency key và immutable audit trail.
- Checkpoint runtime tách khỏi product state và durable business record.
- Prompt không chứa business rule cần tính đúng; đưa rule vào logic có thể kiểm thử.
- Retry không đồng nghĩa rollback; external side effect cần compensation rõ ràng.
