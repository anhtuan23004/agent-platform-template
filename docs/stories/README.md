# Stories

Stories are work packets. They turn product intent into bounded implementation
and validation work.

No story packets are active yet.

## Work Breakdown

Use this hierarchy for product and technical specs:

```text
SPEC-001 Product or technical spec
  -> E01 Epic
      -> US-001 User story
          -> T001 Task
      -> SP-001 Spike
          -> T002 Research task
```

Rules:

- Create candidate epics during spec intake, but do not create every possible
  story or task up front.
- Create a story or spike packet only when the work is selected or when a
  product decision needs a durable place to land.
- Choose a spike when the next answer is about feasibility or technology
  selection. Choose a story when the approach is known and the next work is
  implementing behavior.
- If both learning and early value are needed, run a short spike first, then
  create the story from its outcome.
- Create tasks only inside the selected story or spike.
- Every item must name in-scope, out-of-scope, optional work, and proof.
- Optional work is never required for acceptance criteria.
- Out-of-scope work must become a separate story, spike, decision, or backlog
  item before implementation.

## Epic

Use `docs/templates/epic.md` when a spec slice is large enough to group several
stories or spikes.

Suggested path:

```text
docs/stories/epics/E01-domain-name/epic.md
```

## Normal Story

Use `docs/templates/story.md` for normal feature work.

Suggested path:

```text
docs/stories/epics/E01-domain-name/US-001-short-story-title.md
```

## High-Risk Story

Use `docs/templates/high-risk-story/` when the feature intake classifies work as
high-risk.

Suggested path:

```text
docs/stories/epics/E02-risky-domain/US-012-risky-story-title/
  execplan.md
  overview.md
  design.md
  validation.md
```

## Spike

Use `docs/templates/spike.md` when the next step is resolving uncertainty
instead of shipping product behavior.

Spike outputs must answer the question with evidence. They should name the
recommended path, rejected alternatives, tradeoffs, and any follow-up story or
decision. Do not let a spike become implementation work unless that production
behavior is explicitly listed in scope.

Suggested path:

```text
docs/stories/epics/E01-domain-name/SP-001-short-spike-title.md
```

## Tasks

Use `docs/templates/task-list.md` inside a story or spike folder when task-level
tracking is needed. For single-file story packets, use the `## Tasks` section in
`docs/templates/story.md`.

Task ownership rules:

- One sub-agent owns at most one task at a time.
- Each task must map to one parent story or spike.
- Each task must define owner, write scope, scope, out-of-scope work, optional
  work, dependencies, and proof.
- A task's write scope should avoid overlapping another active task's write
  scope.
- Sub-agents report files changed, validation run, blockers, and discovered
  out-of-scope work. The conductor updates durable status and evidence.
- New work found during a task must become a separate task, story, spike,
  decision, or backlog item before implementation.

## Status Flow

```text
draft -> ready -> in_progress -> blocked -> done
                             |
                             v
                          changed
                             |
                             v
                          retired
```

The durable story proof matrix uses `planned`, `in_progress`, `implemented`,
`changed`, and `retired`. Hierarchical work items use the status flow above.
