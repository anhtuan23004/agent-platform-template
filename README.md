# Agent Flatform Template

Tài liệu + skeleton + Harness để thiết kế và triển khai AI Agent doanh nghiệp
(runtime-neutral; LangChain/LangGraph là adapter). UAT mặc định: FPT Cloud
(1 Cloud Server + Compose).

## Entrypoints

| File | Ai đọc |
|---|---|
| [`AGENTS.md`](AGENTS.md) | Mọi coding agent |
| [`CLAUDE.md`](CLAUDE.md) | Claude Code (import harness context) |
| [`STRUCTURE.md`](STRUCTURE.md) | Cây ownership packages/modules/apps |
| [`docs/architecture/index.md`](docs/architecture/index.md) | Bộ tài liệu kiến trúc agent |
| [`docs/harness/HARNESS.md`](docs/harness/HARNESS.md) | Operating model cho từng change |

## Harness (điều khiển từng change)

Mọi thay đổi material đi qua intake → work item → proof → trace. Durable state
ở `harness.db` (gitignored); CLI: `scripts/bin/harness-cli`.

```bash
scripts/bin/harness-cli init && scripts/bin/harness-cli migrate
scripts/bin/harness-cli query matrix
scripts/bin/harness-cli intake --type change_request --summary "<summary>" --lane normal
```

Chi tiết: [`docs/harness/FEATURE_INTAKE.md`](docs/harness/FEATURE_INTAKE.md),
[`docs/harness/CONTEXT_RULES.md`](docs/harness/CONTEXT_RULES.md).

## Layout nhanh

```text
apps/                 # composition + api + worker (see apps/README.md)
packages/             # kernel, runtime, governance, shared-*
modules/              # domain: identity, knowledge, …
infra/                # FPT Cloud UAT
.github/              # CI/CD UAT
templates/            # Architecture form templates
docs/architecture/    # Agent architecture docs
docs/harness/         # Change operating model
scripts/              # harness-cli + schema
```

## UAT deploy

Xem [`infra/fpt-cloud-uat/README.md`](infra/fpt-cloud-uat/README.md) và
[`.github/CONTRIBUTING-CI.md`](.github/CONTRIBUTING-CI.md).
