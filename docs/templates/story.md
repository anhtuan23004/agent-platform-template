# US-XXX Story Title

## Status

planned

## Lane

tiny | normal | high-risk

## Product Contract

Describe the behavior this story must make true.

## Parent Trace

- Spec: `SPEC-XXX`
- Epic: `E00`
- Durable item: `US-XXX`

## Relevant Product Docs

- `docs/product/...`

## Scope

In scope:

- Item.

Out of scope:

- Item.

Optional:

- Item that may be done only after all acceptance criteria pass.

## Acceptance Criteria

- Criterion 1.
- Criterion 2.
- Criterion 3.

## Tasks

Keep tasks small enough to complete and verify independently.

| Task | Status | Depends on | Proof |
| --- | --- | --- | --- |
| T001 | draft | none | |

## Design Notes

- Commands:
- Queries:
- API:
- Tables:
- Domain rules:
- UI surfaces:

## Validation

When updating durable proof status, use numeric booleans:
`scripts/bin/harness-cli story update --id <id> --unit 1 --integration 1 --e2e 0 --platform 0`.

| Layer | Expected proof |
| --- | --- |
| Unit | |
| Integration | |
| E2E | |
| Platform | |
| Release | |

## Harness Delta

Document any harness updates made or proposed because of this story.

## Evidence

Add commands, reports, screenshots, or links after validation exists.
