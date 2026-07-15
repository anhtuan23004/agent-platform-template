# apps/composition

Composition boundary dùng chung cho `apps/api` và `apps/worker`. Đây là **nơi duy nhất**
được phép import đồng thời runtime adapter concrete, platform implementation và public
contribution của `modules/*`.

## Contract boot (khi implement)

`buildPlatformComposition(environment)` wire:

- runtime adapters, persistence, governance, event dispatcher;
- module public surfaces và agent-tool contributions;
- registry dùng chung cho API chat, workflow worker và resume path.

## Layout dự kiến (language-neutral)

```text
composition/
└── src/
    ├── index              # public entry
    ├── types              # composition types
    ├── build              # buildPlatformComposition
    ├── register-platform  # runtime / persistence / governance
    └── register-modules   # module public surfaces + agent-tools
```

Chọn stack khi review kiến trúc; chưa commit source/package manifest tại đây.

## Dependency exception

`packages/*` không import `modules/*`. Ngoại lệ chỉ folder này — xem
[architecture policy](../../config/architecture-policy.yaml).

Không đặt HTTP handler, graph node, domain rule hay DB query ở đây.
