# Infra

Hạ tầng cho repo này. **Phạm vi hiện tại: UAT only** — không MFKE/prod.

| Path | Mục đích |
|---|---|
| [`fpt-cloud-uat/`](fpt-cloud-uat/README.md) | 1 Cloud Server + Docker Compose trên FPT Cloud |
| [`.github/`](../.github/CONTRIBUTING-CI.md) | CI/CD giống agent-platform `.github` (UAT) |

Prod (LB + MFKE + Managed PG) deferred — khi cần, tách từ topology UAT, không nâng cấp “tại chỗ”.
