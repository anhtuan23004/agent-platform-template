# apps/api

Channel/API process — auth, HTTP/SSE, canonical stream translation.

Tương đương nửa transport của agent-platform `apps/server`. Composition và agent
bind nằm ở [`../composition`](../composition/README.md).

## Layout dự kiến

```text
api/
└── src/
    ├── main.ts
    ├── env.ts
    ├── create-http-app.ts
    └── routes/
        ├── health.ts      # /health/live, /health/ready
        └── chat.ts        # POST /api/agent/v1/chat → chatRuntime (in-process)
```

## Không sở hữu

Domain rules, LangChain/LangGraph imports, module DB clients.
