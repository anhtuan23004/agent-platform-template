# ingestion

Pipeline ingest tài liệu/domain data vào knowledge hoặc feature stores:
job lifecycle, domain adapter registry, review contracts.

## Layout

| Path | Ownership |
|---|---|
| `domain/` | Job/checkpoint aggregates, guard rules |
| `application/` | Start/status/cancel + adapter registry surface |
| `agent-tools/` | Status/read tools; start job theo risk policy |
| `tests/` | unit / contract / integration |

## Không sở hữu

Knowledge document truth (module `knowledge`), embedding/storage shared libs.
