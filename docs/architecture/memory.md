# Memory architecture

[← Mục lục](index.md)

## Phân loại

| Loại | Nội dung | Tuổi thọ | System of record |
|---|---|---|---|
| Working state | Bước hiện tại, intermediate result, retry count | Một run | Runtime checkpoint |
| Conversation | User/assistant messages, citations, tool summaries | Theo product policy | Platform |
| Semantic memory | Facts/preferences đã được xác minh | Theo consent/retention | Platform memory store |
| Episodic history | Kết quả và hành động trước đây | Theo audit/product policy | Platform/audit |
| Domain knowledge | Policies, documents, master data | Theo domain lifecycle | Domain/knowledge system |

Checkpoint không phải long-term memory. Vector index không phải source of truth.

## Write path

1. Memory candidate có provenance, confidence, tenant/subject và classification.
2. Policy quyết định discard, session-only, require consent hoặc persist.
3. Redact secrets/PII không cần thiết; mã hóa theo classification.
4. Upsert idempotently và tạo audit event.
5. Propagate update/delete tới index; source record thắng khi index lệch.

## Read path

1. Filter cứng theo tenant, actor, purpose và classification trước semantic ranking.
2. Retrieve top-k có budget; rerank và loại duplicate/stale item.
3. Đưa provenance và thời điểm cập nhật vào context.
4. Không coi retrieved text là trusted instruction; chống indirect prompt injection.
5. Ghi lại memory IDs đã dùng để phục vụ giải thích và xóa theo yêu cầu.

## Policy bắt buộc

- Data minimization, lawful purpose/consent, retention, export và right-to-delete.
- Field-level classification; không embedding secret/credential.
- Tenant-isolated encryption keys khi risk yêu cầu.
- Context/token budget và freshness window.
- Conflict resolution: nguồn authoritative, human correction và tombstone.
- Evaluation: retrieval precision, stale-memory rate, leakage tests và deletion SLA.

Điền [Memory policy template](../../templates/memory-policy.template.yaml) cho từng agent/use case.

