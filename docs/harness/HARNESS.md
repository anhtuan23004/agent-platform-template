# Harness

Harness is the repository-level operating model for turning human intent or a
Product/Technical Spec into bounded, validated work.

The app is what users touch. Harness is what humans and coding agents use to
understand scope, choose proof, track progress, and leave useful evidence for
the next task.

## Operating Loop

```text
human intent or supplied spec
  -> feature intake
  -> product contract
  -> work item hierarchy
  -> story, spike, or task execution
  -> validation proof
  -> durable progress update
  -> trace or backlog record
```

Every task can produce two outputs:

- Product delta: app code, tests, API shape, data model, or product docs.
- Harness delta: docs, templates, validation expectations, backlog items, or
  packets that make future work clearer.

## Agent Orchestration

Harness uses a conductor model for multi-agent work:

- The conductor owns planning, task assignment, integration, validation, and
  durable status updates.
- A sub-agent may own exactly one task at a time.
- Sub-agents do not implement whole epics or unbounded stories.
- Each delegated task must have a parent story or spike, a bounded write scope,
  explicit out-of-scope notes, and expected proof.
- If a sub-agent discovers new work, it reports the finding instead of expanding
  scope. The conductor creates a new task, story, spike, or backlog
  item when needed.

The durable state is updated by the conductor after reviewing the sub-agent's
result and evidence.

## Closed-Loop Harness Evolution

Harness improvements follow a closed loop:

```text
trace friction or verifier failure
  -> normalized failure pattern
  -> evidence-backed proposal
  -> held-in and held-out eval run
  -> proposal promotion or rejection
```

Use failure attribution when a trace reveals a reusable failure mechanism:

```bash
scripts/bin/harness-cli failure add \
  --trace <trace-id> \
  --signature "<stable-name>" \
  --category context-gap \
  --summary "<what failed>" \
  --causal root \
  --verifier-grounded 1
```

Cluster failures and generate proposals:

```bash
scripts/bin/harness-cli failure cluster
scripts/bin/harness-cli propose --from-failures
```

Committed proposals remain backlog-reviewed, then pass eval gates before
promotion:

```bash
scripts/bin/harness-cli propose --from-failures --commit
scripts/bin/harness-cli eval run --proposal <proposal-id>
scripts/bin/harness-cli proposal promote --id <proposal-id>
```

Do not promote a Harness behavior change unless held-out evals do not regress
and at least one eval passes.

## Source Of Truth

Policy docs describe how to work. The durable layer stores what happened.

| Surface | Purpose |
| --- | --- |
| `docs/product/` | Current product contract derived from accepted input |
| `docs/stories/` | Epic, story, spike, and task packets with context and evidence |
| `scripts/schema/` | Version-controlled SQLite schema migrations |
| `harness.db` | Local operational records, ignored by git |
| `scripts/bin/harness-cli` | Main interface for durable state |

Use markdown for intent, scope, rationale, and evidence detail. Use the CLI for
status, proof flags, trace records, backlog items, and queryable progress.

## Required First Commands

Initialize local durable state when needed:

```bash
scripts/bin/harness-cli init
scripts/bin/harness-cli migrate
```

Inspect current progress before planning work:

```bash
scripts/bin/harness-cli query work-items
scripts/bin/harness-cli query matrix
scripts/bin/harness-cli query stats
```

## Intake

Classify each request before implementation. The detailed rules live in
`docs/harness/FEATURE_INTAKE.md`.

Input types:

- `new_spec`
- `spec_slice`
- `change_request`
- `new_initiative`
- `maintenance`
- `harness_improvement`

Risk lanes:

- `tiny`
- `normal`
- `high-risk`

Record intake when the work is material enough to need traceability:

```bash
scripts/bin/harness-cli intake --type <type> --summary "<summary>" --lane <lane>
```

## Work Breakdown

Product and technical specs decompose through this hierarchy:

```text
spec -> epic -> story or spike -> task
```

Use durable work items for traceable breakdown:

```bash
scripts/bin/harness-cli work-item add --id SPEC-001 --type spec --title "<spec title>"
scripts/bin/harness-cli work-item add --id E01 --type epic --parent SPEC-001 --title "<epic title>"
scripts/bin/harness-cli work-item add --id US-001 --type story --parent E01 --title "<story title>"
scripts/bin/harness-cli work-item add --id SP-001 --type spike --parent E01 --title "<spike title>"
scripts/bin/harness-cli work-item add --id T001 --type task --parent US-001 --title "<task title>"
```

Every work item should make these fields explicit:

- Scope.
- Out-of-scope work.
- Optional work.
- Acceptance criteria or spike exit criteria.
- Status.
- Evidence.

Query the tree:

```bash
scripts/bin/harness-cli query work-items
scripts/bin/harness-cli query work-items --parent E01
```

Detailed story, spike, and task rules live in `docs/stories/README.md`.
Reusable packet formats live in `docs/templates/`.

## Proof And Progress

Story proof status is stored in the durable story matrix:

```bash
scripts/bin/harness-cli story add --id US-001 --title "<story title>" --lane normal
scripts/bin/harness-cli story update --id US-001 --status in_progress
scripts/bin/harness-cli story update --id US-001 --unit 1 --integration 1 --e2e 0 --platform 0 --evidence "<proof>"
scripts/bin/harness-cli query matrix
```

Proof flags use numeric values:

- `1` means yes.
- `0` means no.

Mechanical verification commands can be attached to stories:

```bash
scripts/bin/harness-cli story update --id US-001 --verify "cargo test --workspace"
scripts/bin/harness-cli story verify US-001
scripts/bin/harness-cli story verify-all
```

Do not mark a story implemented until the required acceptance criteria and
proof for that story exist.


## Trace And Friction

Record what happened before closing non-trivial work:

```bash
scripts/bin/harness-cli trace \
  --summary "<what changed>" \
  --agent codex \
  --outcome completed \
  --actions "<actions>" \
  --read "<files or commands read>" \
  --changed "<files changed>" \
  --friction "none"
```

Use `docs/harness/TRACE_SPEC.md` for required trace depth. Use
`scripts/bin/harness-cli score-trace` and
`scripts/bin/harness-cli score-context <trace-id>` when reviewing trace quality
or context coverage.

For fleet-style delegation, link child traces to the parent trace and the
bounded work item:

```bash
scripts/bin/harness-cli trace \
  --summary "<sub-agent result>" \
  --parent-trace <parent-trace-id> \
  --work-item <task-id> \
  --agent worker \
  --outcome completed
```

Sub-agent traces without a bounded work item are audit drift.

When the task reveals missing rules, stale docs, repeated manual work, or
unclear validation, record friction or backlog:

```bash
scripts/bin/harness-cli backlog add \
  --title "<short title>" \
  --pain "<what was hard>" \
  --risk normal
```

The improvement loop is documented in `docs/harness/IMPROVEMENT_PROTOCOL.md`.

## Done Definition

A task is done only when:

- The requested change is complete, or the blocker is documented.
- Relevant product docs, story packets, and proof records are
  current.
- Required validation has run, or the validation gap is explicit.
- Work item and story status reflect reality.
- Out-of-scope and optional work did not silently enter acceptance criteria.
- Friction or missing harness capability has been recorded when found.
- The final response names what changed and what was not attempted.

## Reference Map

- `docs/harness/FEATURE_INTAKE.md`: request classification and risk lanes.
- `docs/harness/CONTEXT_RULES.md`: what context to read per phase and lane.
- `docs/architecture/ARCHITECTURE.md`: default architecture boundaries.
- `docs/stories/README.md`: epic, story, spike, and task packet rules.
- `docs/harness/TEST_MATRIX.md`: proof matrix reference; current rows come from
  `scripts/bin/harness-cli query matrix`.
- `docs/harness/TOOL_REGISTRY.md`: CLI and tool manifest reference.
- `docs/harness/TRACE_SPEC.md`: trace quality requirements.
- `docs/harness/HARNESS_AUDIT.md`: audit and entropy categories.
- `docs/harness/IMPROVEMENT_PROTOCOL.md`: proposal and backlog outcome loop.
