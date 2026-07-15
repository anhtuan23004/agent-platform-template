# persistence

Platform-owned stores và runtime store adapters: conversation, approvals,
durable memory, audit projection, checkpoint persistence qua ports.

## Layout

```text
src/     # Store adapters, migrations, tenant scoping
tests/   # Isolation, resume, retention
```

## Public surface (planned)

| Entry | Purpose |
|---|---|
| `persistence` | Platform store facades implementing ports |
| `persistence/migrations` | Schema owned by platform |
| `persistence/testing` | Tenant-scoped fixtures |

## Không sở hữu

Cross-domain table access, domain aggregate internals.
