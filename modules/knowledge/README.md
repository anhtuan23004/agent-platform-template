# knowledge

Tenant knowledge base — document lifecycle, chunking metadata và RAG
contribution. Domain record là source of truth; vector index chỉ là projection.

Xem [Memory architecture](../../docs/architecture/memory.md).

## Layout

| Path | Ownership |
|---|---|
| `domain/` | Document/corpus aggregates, retention rules |
| `application/` | Upload/query/delete public surface + events |
| `agent-tools/` | Read/search tools cho agent |
| `tests/` | unit / contract / integration |

## Không sở hữu

Embedding providers (`shared-embeddings`), retrieval primitives
(`shared-retrieval`), object storage (`shared-storage`).
