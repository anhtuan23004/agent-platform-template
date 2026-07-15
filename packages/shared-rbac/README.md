# shared-rbac

Pure role/permission primitives — role catalog, permission constants và
`can(role, permission)`. Không I/O. `identity` bind roles; mọi handler
re-check capability tại callee.


## Public surface (planned)

| Entry | Purpose |
|---|---|
| `shared-rbac` | Roles, permissions, capability resolution |
