# runtime-langgraph

LangGraph adapter: graph execution, checkpoint, interrupt/resume.
Checkpoint chỉ phục vụ recovery — không phải product state.

## Layout

```text
src/     # WorkflowRuntime, CheckpointStore adapter
tests/   # Crash/resume và interrupt contract tests
```

## Public surface (planned)

| Entry | Purpose |
|---|---|
| `runtime-langgraph` | `WorkflowRuntime` + checkpoint adapter |
| `runtime-langgraph/testing` | Graph fixtures, resume helpers |

## Không sở hữu

Approval system of record, durable business memory, domain mutations.
