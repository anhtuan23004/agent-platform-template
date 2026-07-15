# Task List

Use this file inside a story or spike folder when the work needs task-level
tracking. Do not create tasks for every possible future story up front.

## Parent Trace

- Spec: `SPEC-XXX`
- Epic: `E00`
- Story/Spike: `US-XXX`

## Ownership Model

One sub-agent may own exactly one task at a time. The conductor assigns tasks,
reviews results, runs or verifies proof, and updates durable Harness status.

## Tasks

| Task | Owner | Status | Write scope | Scope | Out of scope | Optional | Depends on | Proof |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| T001 | unassigned | draft | | | | | none | |

## Status Values

```text
draft -> ready -> in_progress -> blocked -> done
                              |
                              v
                           changed
                              |
                              v
                           retired
```

## Rules

- Each task must map to one parent story or spike.
- Each task may have only one active owner.
- Each task must define the files, modules, or docs the owner may change.
- Each task must have a clear proof, even if the proof is review-only.
- Active tasks should not share write scope unless the conductor explicitly
  sequences them.
- Optional work cannot be required for the parent acceptance criteria.
- Out-of-scope work must become a new story, spike, or backlog item before implementation.
