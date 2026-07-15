# Modules

Domain modules — mỗi module sở hữu business truth, public use cases và
agent-tool contributions. Composition root trong `apps/` collect tools và
inject vào runtime.

Platform libs (kernel, runtime, shared) nằm ở [`packages/`](../packages/README.md).

## Quy ước layout

```text
modules/<name>/
├── domain/          # Aggregate, rules, mutations — framework-independent
├── application/     # Public surface (commands/queries) + events
├── agent-tools/     # ToolSpec + closures gọi application (không gọi DB trực tiếp)
└── tests/
    ├── unit/
    ├── contract/
    └── integration/
```

## Modules

| Module | Vai trò |
|---|---|
| `identity` | Optional capability: users, orgs, sessions, SSO, RBAC bindings |
| `knowledge` | Optional capability: tenant KB, document lifecycle, RAG tools |
| `integrations` | Optional capability: credentials, connectors, external APIs |
| `notifications` | Optional capability: in-app notify, preferences, realtime delivery |
| `ingestion` | Optional capability: document/domain ingest pipelines |
| `example-feature` | Starter template cho feature nghiệp vụ đầu tiên |

Chỉ activate optional module sau ADR/use case có owner. Read-only tracer bullet có thể chỉ dùng
`example-feature` và các package thật sự cần thiết.

## Quy tắc

1. Tool closure chỉ gọi `application/` public surface; `domain/` re-check tenant/RBAC.
2. Không import `runtime-langchain` / `runtime-langgraph`.
3. Cross-module: public contract hoặc schema-validated event qua public `core/events` — không
   import internals.
4. Schema DB theo module; không cross-schema queries.

Chi tiết: [STRUCTURE.md](../STRUCTURE.md), [Boundaries](../docs/architecture/boundaries.md).
