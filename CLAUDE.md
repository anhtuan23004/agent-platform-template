# Project Rules

Enterprise AI agent architecture template. Prefer `STRUCTURE.md` and
`docs/architecture/index.md` for platform shape; use Harness for every material
change.

<!-- HARNESS:BEGIN -->
## Harness

Claude Code loads this file into every session, but it does not auto-load
`AGENTS.md`. The bare `@` lines below import the always-required harness
context (the "Must in all lanes" set from `docs/harness/CONTEXT_RULES.md`) at
context-load time. Never wrap them in backticks; that disables the import.

@AGENTS.md

@docs/harness/FEATURE_INTAKE.md

Also run `scripts/bin/harness-cli query matrix` before starting work.

Lane-dependent context (`README.md`, `docs/harness/HARNESS.md`,
`docs/architecture/ARCHITECTURE.md`, `STRUCTURE.md`,
`docs/harness/CONTEXT_RULES.md`, product docs, stories) is intentionally not
imported — read it per lane, as `docs/harness/CONTEXT_RULES.md` prescribes.
<!-- HARNESS:END -->
