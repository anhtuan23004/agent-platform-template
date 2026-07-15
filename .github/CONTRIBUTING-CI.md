# GitHub Actions & automation

Layout mirrors `agent-platform/.github`, adapted for **FPT Cloud UAT** (single
Cloud Server + Compose). Production release (ECS/MFKE) is out of scope.

```text
.github/
├── dependabot.yml
├── actions/
│   └── build-images/action.yml   # Composite: buildx + registry login/push
└── workflows/
    ├── ci.yml                    # PR/main structure gates
    ├── iac.yml                   # infra/** validation
    ├── uat-release.yml           # Build → registry → SSH deploy
    ├── uat-rollback.yml          # Redeploy previous image tag
    ├── uat-db-reset.yml          # down -v → migrate → seed → up
    └── uat-clear-caches.yml      # Actions cache + Docker prune on host
```

| agent-platform | Template |
|---|---|
| `ci.yml` | `ci.yml` |
| `iac.yml` | `iac.yml` |
| `hackathon-release.yml` | `uat-release.yml` |
| `hackathon-rollback.yml` | `uat-rollback.yml` |
| `hackathon-db-reset.yml` | `uat-db-reset.yml` |
| `hackathon-clear-caches.yml` | `uat-clear-caches.yml` |
| `release.yml` (prod ECS) | deferred |
| `actions/build-images` (ECR) | `actions/build-images` (generic registry) |
| `dependabot.yml` | `dependabot.yml` |

Environment, secrets, and deploy steps: [`infra/fpt-cloud-uat/README.md`](../infra/fpt-cloud-uat/README.md).
