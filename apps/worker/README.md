# apps/worker

Durable workflow, outbox dispatcher và background jobs.

Tương đương agent-platform `apps/worker`: **cùng composition** với API, không mount HTTP.

## Layout dự kiến

```text
worker/
└── src/
    ├── main.ts    # buildPlatformComposition({ role: 'worker' }) → start
    └── env.ts
```

## Quy tắc

1. Gọi composition — không tự import `modules/*`.
2. Production: dispatcher **singleton**. UAT có thể chạy process riêng trên cùng VM.
3. Graceful shutdown drain jobs trước khi exit.
