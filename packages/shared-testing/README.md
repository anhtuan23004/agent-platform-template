# shared-testing

Shared test utilities — Postgres testcontainers, schema bootstrap, fakes
và integration helpers.


## Layout

```text
src/
  fakes/     # In-memory port fakes
tests/unit/
```

## Public surface (planned)

| Entry | Purpose |
|---|---|
| `shared-testing` | `withTestDb`, fixtures, containers |
| `shared-testing/fakes` | Port fakes cho contract tests |
