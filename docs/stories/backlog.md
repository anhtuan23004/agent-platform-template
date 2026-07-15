# Story Backlog

This backlog will be populated after a user provides a project spec or selects a
specific initiative.

Do not create every possible story packet up front. Create story packets when
the work is selected or when a product decision needs a durable place to land.

## Candidate Epics

No candidate epics exist yet.

Create candidate epics as durable work items after spec intake:

```bash
scripts/bin/harness-cli work-item add --id E01 --type epic --parent SPEC-001 --title "<epic title>"
```

## Candidate Stories And Spikes

No candidate stories or spikes exist yet.

Create them only when the work is selected or a product decision needs a
durable place to land:

```bash
scripts/bin/harness-cli work-item add --id US-001 --type story --parent E01 --title "<story title>"
scripts/bin/harness-cli work-item add --id SP-001 --type spike --parent E01 --title "<spike title>"
```
