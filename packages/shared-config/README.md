# shared-config

Shared toolchain config — base compiler/linter settings, boundary lint rules và
guard scripts enforce modular-monolith contracts. Dùng như `devDependency`
của mọi package khi stack được chốt.


## Public surface (planned)

| Entry | Purpose |
|---|---|
| `shared-config/base` | Shared compiler / toolchain defaults |
| `shared-config/boundaries` | Forbidden-import / public-surface rules |
