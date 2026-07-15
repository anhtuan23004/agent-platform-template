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

## Matrix

No durable story proof records exist yet.

Create and update rows with:

```bash
scripts/bin/harness-cli story add --id US-001 --title "<story title>" --lane normal
scripts/bin/harness-cli story update --id US-001 --status implemented --unit 1 --integration 1 --e2e 0 --platform 0 --evidence "<proof>"
```

## Evidence Rules

- Unit proof covers pure domain and application rules.
- Integration proof covers backend enforcement, data integrity, provider
  behavior, jobs, or service contracts.
- E2E proof covers user-visible browser flows.
- Platform proof covers only shell, deployment, mobile, desktop, or runtime
  behavior that cannot be proven in lower layers.
- A story can be implemented without every proof column if the story packet
  explains why.
