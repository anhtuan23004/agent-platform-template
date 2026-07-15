# Improvement Protocol

Harness improvements follow a measured feedback loop:

```text
friction + interventions + audit findings
  -> harness-cli propose
  -> proposed backlog item
  -> human review
  -> implementation with predicted impact
  -> close with actual outcome
```

Self-Harness improvements use a stricter loop:

```text
trace failure
  -> harness-cli failure add
  -> harness-cli failure cluster
  -> harness-cli propose --from-failures
  -> backlog review
  -> harness-cli eval run --proposal <id>
  -> harness-cli proposal promote --id <id>
```

## Generate Proposals

```bash
scripts/bin/harness-cli propose
```

The command is rule-based. It looks for:

- repeated trace friction,
- repeated normalized failure patterns,
- high-risk verifier-grounded failure patterns,
- repeated intervention patterns,
- non-zero audit categories.

Each proposal includes title, component, evidence, predicted impact, risk,
suggested action, validation plan, and confidence.

## Commit Proposals

```bash
scripts/bin/harness-cli propose --commit
```

Committed proposals become `proposed` backlog items. Humans review them with:

```bash
scripts/bin/harness-cli query backlog --open
```

## Review Rules

- Tiny proposals may be implemented directly when they only clarify docs.
- Normal proposals need a story packet or clear backlog acceptance.
- High-risk proposals need a durable decision record before changing source
  hierarchy, architecture direction, validation requirements, or risk policy.
- Completed proposal work must close the backlog item with actual outcome
  evidence.
- Self-Harness proposals need at least one recorded eval pass and zero failed
  held-out evals before promotion.

## Validation

After implementation, compare the predicted impact with:

- `scripts/bin/harness-cli audit`,
- `scripts/bin/harness-cli query friction`,
- `scripts/bin/harness-cli query failures`,
- `scripts/bin/harness-cli eval report`,
- `scripts/bin/harness-cli query interventions`,
- benchmark trace quality and harness compliance when benchmark proof applies.
