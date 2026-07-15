# shared-config

Shared toolchain config — base tsconfig, boundary lint rules và guard
scripts enforce modular-monolith contracts. Dùng như `devDependency`
của mọi package.


## Public surface (planned)

| Entry | Purpose |
|---|---|
| `shared-config/tsconfig.base.json` | Base TS options |
| `shared-config/eslint/boundaries` | Forbidden-import / public-surface rules |
