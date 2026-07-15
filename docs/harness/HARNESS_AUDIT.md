# Harness Audit

`scripts/bin/harness-cli audit` detects drift in durable Harness state and
prints an entropy score. Lower is better.

Project gate (required in CI): `scripts/bin/harness-proof-audit` extends the
binary audit with coverage-illusion checks the CLI does not yet score.

## Checks (`harness-cli audit`)

| Category | Meaning | Weight |
| --- | --- | --- |
| Orphaned stories | Planned or in-progress stories with no linked trace. | 10 |
| Unverified stories | Stories with `verify_command` but no recorded verification result. | 5 |
| Unverified decisions | Decisions with `verify_command` but no recorded verification result. | 5 |
| Open backlog without outcomes | Implemented backlog items with predicted impact but no actual outcome. | 2 |
| Stale stories | Unimplemented stories whose latest linked trace is more than 30 days old. | 3 |
| Broken tools | Registered tools whose command is not found on disk or `PATH`. | 8 |
| Trace without story/work item | Normal or high-risk traces that are not linked to a story or work item. | 6 |
| Story without work item | Story proof rows without matching hierarchy records. | 6 |
| Done work item without trace | Done work items with no trace evidence. | 6 |
| Sub-agent trace without work item | Child traces that are not bounded by a work item. | 8 |
| Parent trace with failed child | Completed parent traces with failed or partial child traces. | 8 |
| Delegated task without proof | Delegated task traces whose task/story has no evidence. | 5 |

## Checks (`harness-proof-audit`)

| Category | Meaning | Weight |
| --- | --- | --- |
| Implemented without proof/waiver | `story.status=implemented` with all proof flags 0 and empty `proof_waiver`. | 15 |
| Implemented without acceptance criteria | Implemented story whose matching work item lacks `acceptance_criteria`. | 15 |
| Story / work-item status mismatch | e.g. matrix `implemented` while work item still `draft`. | 8 |
| Evidence path missing | Path-like tokens in `evidence` that do not exist on disk. | 10 |
| Missing artifact | Evidence claims source/stubs/implementation while apps/packages/modules only have docs/`.gitkeep`. | 12 |

## Implemented gate (schema migration 007)

SQLite triggers reject `story` inserts/updates to `implemented` unless:

1. Matching `work_item` (`story`/`spike`) has non-empty `acceptance_criteria`, and
2. At least one proof flag is set **or** `proof_waiver` is non-empty, and
3. `evidence` is non-empty.

Set a waiver only via explicit SQL until the CLI grows a flag:

```bash
scripts/bin/harness-cli query sql \
  "UPDATE story SET proof_waiver = 'docs-only skeleton; tracked in US-00N' WHERE id = 'US-001';"
```

Migration 007 also demotes pre-existing invalid `implemented` rows to
`in_progress`.

## Score

```text
score = orphaned_stories * 10
      + unverified_stories * 5
      + unverified_decisions * 5
      + backlog_without_outcomes * 2
      + stale_stories * 3
      + broken_tools * 8
      + trace_without_story * 6
      + story_without_work_item * 6
      + work_item_done_without_trace * 6
      + subagent_trace_without_work_item * 8
      + parent_trace_with_failed_child * 8
      + delegated_task_without_proof * 5
```

The score is capped at 100.

| Range | Interpretation |
| --- | --- |
| 0 | Perfect: records are traced, verified, and healthy. |
| 1-25 | Healthy: minor housekeeping remains. |
| 26-50 | Attention needed: drift is accumulating. |
| 51-100 | Action required: stale state undermines Harness value. |

Audit findings feed `scripts/bin/harness-cli propose`, which can turn repeated
drift into proposed backlog items.

Always run both:

```bash
scripts/bin/harness-cli audit
scripts/bin/harness-proof-audit
```
