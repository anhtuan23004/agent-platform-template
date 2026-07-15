# Mapping LangChain/LangGraph

[← Mục lục](index.md)

## Quyết định

Kiến trúc là runtime-neutral. LangChain phù hợp cho agent/tool abstraction; LangGraph phù hợp
cho state graph, durable checkpoint và interrupt/resume. Chúng là adapter triển khai ports,
không phải public product contract.

| Capability trung lập | Mapping khả dụng | Ranh giới phải giữ |
|---|---|---|
| Adaptive agent loop | LangChain agent | Bounded steps/budget; canonical output |
| Typed tool | LangChain tool với schema | Dispatcher/domain vẫn kiểm quyền |
| Deterministic workflow | LangGraph state graph | Transition/business rule ở code kiểm thử được |
| Working state | LangGraph state/checkpoint | Không coi là durable user/business memory |
| HITL | Interrupt + resume command | Approval record do platform sở hữu |
| Long-term memory | Store/retrieval adapter | Consent, retention, provenance do platform policy |
| Streaming | Graph/agent stream | Chuyển sang canonical stream trước channel protocol |

## Adapter ports đề xuất

- `ChatRuntime`: invoke/stream/cancel với canonical events.
- `WorkflowRuntime`: start/resume/status/cancel qua opaque `ExecutionRef`.
- `CheckpointStore`: save/load/list/delete, tenant-scoped.
- `MemoryStore`: search/upsert/delete với policy metadata và provenance.
- `ToolRegistry/Dispatcher`: collect specs, authorize và invoke closures.

## Integration risks

1. **Migration ownership:** một số checkpointer có thể tự tạo table. Production schema/migration
   phải do platform kiểm soát; không chạy auto-setup ngầm.
2. **Snapshot portability:** checkpoint của runtime cũ thường không map lossless. Drain suspended
   runs bằng runtime cũ hoặc thiết kế explicit conversion đã test.
3. **Stream protocol:** framework stream không đồng nhất UI/API protocol. Cần canonical event
   union và adapter riêng.
4. **Atomicity:** checkpoint commit và domain transaction không tự atomic. Write tool cần
   idempotency, outbox và compensation/reconciliation.
5. **Vendor leakage:** không expose graph node/checkpoint ID hoặc framework message type trong
   public API/product tables.

## Strategy migration/canary

Viết characterization tests trước; extract contracts/ports trong khi giữ runtime cũ; pilot một
read-only agent; shadow chỉ với non-write traffic; thêm HITL/idempotency; migrate workflow đơn
giản; drain suspended runs; cuối cùng mới retire adapter cũ.

API cụ thể thay đổi theo version. Trước implementation phải xác minh tài liệu chính thức của
LangChain/LangGraph và pin/test contract tại adapter boundary.

