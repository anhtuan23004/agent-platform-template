# Harness Audit

`scripts/bin/harness-cli audit` detects drift in durable Harness state and
prints an entropy score. Lower is better.

## Checks

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
