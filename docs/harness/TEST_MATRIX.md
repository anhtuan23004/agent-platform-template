# Test Matrix

This file defines how product behavior maps to proof.

Current proof status is stored in the durable layer and queried with:

```bash
scripts/bin/harness-cli query matrix
scripts/bin/harness-cli query matrix --numeric
```

Do not mark a story implemented until tests or validation evidence exist.

## Status Values

| Status | Meaning |
| --- | --- |
| planned | Accepted as intended behavior, not implemented |
| in_progress | Actively being built |
| implemented | Implemented and proof exists |
| changed | Contract changed after earlier implementation |
| retired | No longer part of the product contract |

## Implemented contract

`implemented` is allowed only when **all** of the following hold (enforced by
schema migration `007-implemented-proof-gate.sql` and
`scripts/bin/harness-proof-audit`):

1. Matching work item has non-empty `acceptance_criteria`.
2. At least one proof flag (`unit` / `integration` / `e2e` / `platform`) is `1`,
   **or** a non-empty `proof_waiver` explains the exception.
3. `evidence` is non-empty and path tokens resolve on disk.
4. Work item status is `done` (or `changed`) — proof audit flags mismatches.

## Matrix

No durable story proof records exist yet.

Create and update rows with:

```bash
scripts/bin/harness-cli work-item update --id US-001 --acceptance "<criteria>" --status done
scripts/bin/harness-cli story add --id US-001 --title "<story title>" --lane normal
scripts/bin/harness-cli story update --id US-001 --status implemented --unit 1 --integration 1 --e2e 0 --platform 0 --evidence "<proof path or note>"
```

## Evidence Rules

- Unit proof covers pure domain and application rules.
- Integration proof covers backend enforcement, data integrity, provider
  behavior, jobs, or service contracts.
- E2E proof covers user-visible browser flows.
- Platform proof covers only shell, deployment, mobile, desktop, or runtime
  behavior that cannot be proven in lower layers.
- A story can be implemented without every proof column if the story packet
  explains why **and** either another proof flag is set or `proof_waiver` is
  recorded.
- Do not cite artifacts that are not in the tree (for example "TypeScript
  stubs" when only README/`.gitkeep` exist).
