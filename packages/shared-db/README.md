# shared-db

Shared Postgres + ORM primitives — pool factory, schema-scoped clients,
transaction helpers và migration runner. Mỗi module sở hữu schema riêng;
không cross-schema queries.


## Public surface (planned)

| Entry | Purpose |
|---|---|
| `shared-db` | `createPool()`, client helpers, migrate, tx |
