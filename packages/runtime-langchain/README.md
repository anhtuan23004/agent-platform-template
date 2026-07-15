# runtime-langchain

LangChain adapter: implement agent/tool/model ports của `agent-kernel`.
Composition root inject adapter; package này không import `modules/*`.

## Layout

```text
src/     # ChatRuntime, tool wrappers, model clients
tests/   # Contract tests vs ports
```

## Public surface (planned)

| Entry | Purpose |
|---|---|
| `runtime-langchain` | `ChatRuntime` implementation |
| `runtime-langchain/testing` | Fake model / deterministic fixtures |

## Không sở hữu

Feature/domain imports, product state, approval system of record.
