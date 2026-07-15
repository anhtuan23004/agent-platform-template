# Agent Instructions

This is an **enterprise AI agent architecture template** (docs + skeleton +
Harness), not a blank product scaffold.

## Project rules

1. Prefer architecture docs and `STRUCTURE.md` over inventing new layering.
2. `packages/` = platform (kernel, runtime, shared). `modules/` = domain
   business truth + `agent-tools/`. Do not put domain aggregates in `packages/`.
3. Backend → agent is **in-process** (ports/functions). HTTP only at `apps/api`
   channel boundary.
4. UAT infra is FPT Cloud single VM + Compose (`.github` UAT workflows). Do not
   introduce MFKE/prod topology unless a high-risk story asks for it.
5. Architecture form templates live in root `templates/`. Harness story templates
   live in `docs/templates/`. Do not mix them.
6. Do not commit secrets (`.env`, `.tfvars`, `secrets.env`, `harness.db`).

Use the Harness CLI as the source of truth for operational state. Markdown docs
explain policy and context; `harness.db` stores intake, work item, story,
backlog, and trace state.

<!-- HARNESS:BEGIN -->
## Harness

This repo uses Harness. Before work, read:

- `README.md`
- `docs/harness/HARNESS.md`
- `docs/harness/FEATURE_INTAKE.md`
- `docs/architecture/ARCHITECTURE.md`
- `docs/harness/CONTEXT_RULES.md`
- `STRUCTURE.md`
- `docs/architecture/index.md` (when the change touches agent architecture)
- `scripts/bin/harness-cli query matrix`

Use the Rust Harness CLI at `scripts/bin/harness-cli` as the main operational
tool.

### Change workflow (required for material work)

```text
intake (type + lane)
  -> work-item hierarchy (spec/epic/story/task) when normal/high-risk
  -> bounded implementation
  -> proof flags / validation
  -> trace (+ backlog if friction)
```

Tiny lane may skip story packets but still records intake + trace when useful.
<!-- HARNESS:END -->
