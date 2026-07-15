# Apps

Process hosts của platform. Pattern tham khảo agent-platform (`apps/server` +
`apps/worker`), tách rõ **composition root**.

| App | Vai trò | Map từ agent-platform |
|---|---|---|
| [`composition/`](composition/README.md) | Wire packages + modules một lần | Logic boot trong `apps/server` / `apps/worker` |
| [`api/`](api/README.md) | HTTP/SSE channel | `apps/server` (transport only) |
| [`worker/`](worker/README.md) | Outbox dispatcher + jobs | `apps/worker` |

```text
api ──┐
      ├──► buildPlatformComposition() ──► packages/* + modules/*
worker┘
```

Quy tắc:

1. Chỉ `composition/` được import `modules/*` public surfaces / agent-tools.
2. `api` và `worker` chỉ import `composition` — không import domain internals.
3. Agent chat/workflow gọi **in-process** qua ports đã wire trong composition.
4. Chưa có source — chỉ folder + README; implement khi chọn stack.

`apps/web` / `apps/cli` thêm sau khi cần UI hoặc migrate CLI.
