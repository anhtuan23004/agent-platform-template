# Architecture

This repository defines an **enterprise AI agent platform** shape. Stack pins
(language, ORM, exact LLM provider) are decided per implementation story when
they constrain future work — record them in story/evidence or product docs, not
a separate decisions tree.

## Canonical sources

| Surface | Purpose |
|---|---|
| [`STRUCTURE.md`](../../STRUCTURE.md) | Directory ownership: apps / packages / modules |
| [`index.md`](index.md) | Architecture doc set (overview → security) |
| [`boundaries.md`](boundaries.md) | Dependency direction, contracts, ports |
| [`overview.md`](overview.md) | Execution loop, layer responsibilities |
| [`packages/README.md`](../../packages/README.md) | Platform packages |
| [`modules/README.md`](../../modules/README.md) | Domain modules + agent-tools |

## Default layering (this project)

```text
apps/ (composition root, channels)
  -> packages/agent-kernel/{application,ports,contracts}
  -> packages/runtime-*  (adapters; no module imports)
  -> packages/governance, persistence, core, shared-*
  -> modules/*/{domain,application,agent-tools}
```

Rules:

1. Ports do not import adapters; application does not import LangChain/LangGraph.
2. Runtime adapters implement ports; they do not import `modules/*`.
3. Module tools call `application/` public surface; domain re-checks RBAC.
4. Cross-module: public surface or schema-validated events only.
5. HTTP/SSE only at channel adapters; agent invoke is in-process function call.

## Discovery before new shape

Before proposing a different shape, identify:

- Product surfaces: API, worker, web, CLI.
- Runtime: language, framework, DB, queues, model providers, hosting.
- Domains that deserve stable contracts vs shared libs.
- Validation ladder: contract / integration / e2e / UAT smoke.

## Hosting (current)

- **UAT:** FPT Cloud — 1 Cloud Server + Docker Compose
  ([`infra/fpt-cloud-uat`](../../infra/fpt-cloud-uat/README.md)).
- **Prod (deferred):** MFKE + Managed PG + Object Storage — not the default path.

## Harness note

This file is the architecture boundary summary referenced by
`docs/harness/CONTEXT_RULES.md` and `AGENTS.md`.
