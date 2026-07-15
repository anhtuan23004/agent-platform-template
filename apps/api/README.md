# apps/api

Channel/API process — auth, HTTP/SSE, canonical stream translation.

Tương đương nửa transport của agent-platform `apps/server`. Composition và agent
bind nằm ở [`../composition`](../composition/README.md).

## Layout dự kiến (language-neutral)

```text
api/
└── src/
    ├── main            # process entry
    ├── env             # config binding
    ├── create-http-app # HTTP app factory
    └── routes/
        ├── health      # /health/live, /health/ready
        └── chat        # POST /api/agent/v1/chat → chatRuntime (in-process)
```

Chọn language/toolchain khi review kiến trúc; folder này chỉ giữ ownership
skeleton cho đến khi có source thật.

## Không sở hữu

Domain rules, LangChain/LangGraph imports, module DB clients.
