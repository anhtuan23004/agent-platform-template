# FPT Cloud — UAT

Topology UAT giống `agent-platform` hackathon: **một Cloud Server công khai + Docker Compose**.
Postgres chạy trên cùng host (container). Không MFKE, không Managed DB, không ALB tách.

> Không dùng cho production. RTO/RPO, HA, WAF, secret manager native — ngoài phạm vi UAT.

## Topology

```text
Internet
   │  :80/:443
   ▼
Cloud Server (Ubuntu 24.04, ≥4 GB RAM / 2 vCPU / 40 GB disk)
   ├── Traefik          # TLS (Let's Encrypt hoặc self-signed)
   ├── web              # static SPA (khi có image)
   ├── server           # API + worker all-in-one (PLATFORM_MODULES=*)
   ├── postgres         # pgvector/pg17, volume local
   └── migrator         # one-shot migrate rồi exit

Object Storage (S3-compatible)  ←── cron pg_dump hàng ngày (optional)
```

Map từ agent-platform:

| agent-platform (hackathon AWS) | FPT Cloud UAT |
|---|---|
| EC2 t3/t4g + EIP | Cloud Server + Floating IP |
| Docker Compose trên host | Docker Compose trên host |
| Postgres container | Postgres container |
| S3 backup bucket | Object Storage bucket |
| Traefik + ACME | Traefik + ACME |
| Security group 22/80/443 | Security Group 22/80/443 |

## Sizing đề xuất

| Resource | UAT |
|---|---|
| Cloud Server | 2 vCPU / 4–8 GB RAM / 40–80 GB SSD |
| OS | Ubuntu 24.04 |
| Disk | System disk đủ; snapshot thủ công trước demo lớn |
| Object Storage | 1 bucket private, lifecycle expire dump ≥7–14 ngày |
| Region | `VN/HAN` hoặc `VN/SGN` theo tenant |

## Provision (Portal — đủ cho UAT)

1. Tạo **VPC/Subnet** (hoặc dùng default của tenant) + **Security Group**:
   - Inbound: `22` (CIDR office), `80`, `443` từ `0.0.0.0/0`
   - Outbound: all (LLM provider, ACME, registry)
2. Tạo **Cloud Server** Ubuntu 24.04, gắn Floating IP, SSH key.
3. (Optional) Tạo **Object Storage** bucket + access key cho backup.
4. DNS: A record `uat.<domain>` → Floating IP.

## Bootstrap host

```bash
ssh ubuntu@<floating-ip>

# Docker Engine 27+ + compose v2
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker ubuntu
# re-login

# App root
sudo mkdir -p /opt/platform && sudo chown ubuntu:ubuntu /opt/platform
cd /opt/platform
# clone repo (hoặc rsync artifact compose + images)
```

## Chạy stack (khi đã có compose + image)

Pattern giống agent-platform self-host:

```bash
cp .env.example .env && chmod 600 .env
# Bắt buộc: DOMAIN, ACME_EMAIL, POSTGRES_PASSWORD, AUTH_SECRET, LLM keys
# UAT: TLS_MODE=letsencrypt (có DNS) hoặc self-signed

docker compose pull
docker compose up -d
docker compose run --rm migrator
docker compose ps
curl -sfk https://uat.<domain>/health/live
```

All-in-one: `server` chạy API + worker trên cùng process/container (đủ UAT; prod mới tách dispatcher singleton).

## Backup (optional)

```bash
# Ví dụ cron hàng ngày — chỉnh endpoint/bucket FPT Object Storage (S3 API)
0 2 * * * docker compose -f /opt/platform/compose.yml exec -T postgres \
  pg_dump -U "$POSTGRES_USER" "$POSTGRES_DB" | gzip | \
  aws --endpoint-url "$FPT_S3_ENDPOINT" s3 cp - "s3://$BACKUP_BUCKET/db/$(date +\%F).sql.gz"
```

Restore: stop stack → restore volume/dump → migrate nếu cần → up.

## Checklist UAT go-live

- [ ] SG chỉ mở 22 từ office; 80/443 public
- [ ] `.env` không commit; secret đủ mạnh
- [ ] DNS trỏ đúng Floating IP; TLS OK
- [ ] `migrator` exit 0 trước khi smoke test
- [ ] Login + 1 chat turn read-only thành công
- [ ] (Optional) backup dump xuất hiện trên Object Storage
- [ ] Snapshot Cloud Server trước demo stakeholder

## CI/CD (giống agent-platform hackathon-release)

```text
PR / push main     →  uat-ci.yml          (structure gates)
workflow_dispatch  →  uat-release.yml
                        ├─ prepare tag (SHA hoặc input)
                        ├─ build/push server+web → FPT Container Registry
                        └─ SSH Cloud Server
                             ├─ docker login registry
                             ├─ secrets.env (generate once, persist on host)
                             ├─ write .env (image tags + runtime)
                             ├─ fetch compose.yml from repo branch
                             ├─ stop app → prune/pull (tránh OOM host 4GB)
                             ├─ migrator
                             ├─ compose up -d --wait
                             └─ smoke https://$APP_DOMAIN/health/ready
```

Workflows (xem [`.github/README.md`](../../.github/README.md)):

| File | Khi chạy | Tương đương agent-platform |
|---|---|---|
| `ci.yml` | PR / push `main` | `ci.yml` |
| `iac.yml` | Đổi `infra/**` | `iac.yml` |
| `uat-release.yml` | Manual deploy | `hackathon-release.yml` |
| `uat-rollback.yml` | Manual rollback tag | `hackathon-rollback.yml` |
| `uat-db-reset.yml` | Manual wipe + seed | `hackathon-db-reset.yml` |
| `uat-clear-caches.yml` | Manual prune caches | `hackathon-clear-caches.yml` |

### GitHub Environment `uat`

| Kind | Name | Ví dụ |
|---|---|---|
| Var | `UAT_HOST` | Floating IP hoặc DNS |
| Var | `UAT_USER` | `ubuntu` |
| Var | `APP_DOMAIN` | `uat.example.com` |
| Var | `REGISTRY` | FPT Container Registry host |
| Var | `REPOSITORY` | `platform` |
| Var | `ACME_EMAIL` | ops@example.com |
| Var | `S3_ENDPOINT` / `S3_BUCKET` | Object Storage (optional) |
| Secret | `UAT_SSH_PRIVATE_KEY` | Deploy key vào Cloud Server |
| Secret | `REGISTRY_USERNAME` / `REGISTRY_PASSWORD` | Pull/push images |
| Secret | `OPENAI_API_KEY` | LLM |
| Secret | `S3_ACCESS_KEY` / `S3_SECRET_KEY` | Backup/upload (optional) |

`build` job trong `uat-release.yml` đang `if: false` cho đến khi có `infra/docker/*.Dockerfile` + `compose.yml`. Deploy SSH vẫn chạy được để kiểm tra secrets/host; sẽ no-op nếu chưa có `compose.yml`.

### Enable build khi có image

1. Thêm `infra/docker/server.Dockerfile`, `web.Dockerfile`, root `compose.yml`.
2. Trong `uat-release.yml`: bỏ `if: false` ở job `build`; đổi `deploy.needs` thành `[prepare, build]`.

## IaC (optional)

Provider: [`fpt-corp/fptcloud`](https://registry.terraform.io/providers/fpt-corp/fptcloud) hoặc OpenStack provider của FPT.

UAT không bắt buộc IaC — Portal + CI/CD đủ. Khi ổn định, thêm `*.tf` provision Cloud Server + Floating IP + SG + Object Storage; **không** đưa Managed PG/MFKE vào path này.

## Ngoài phạm vi UAT

- MFKE / multi-replica server+worker
- Managed PostgreSQL HA
- WAF / private subnet only
- Cross-region DR, PITR managed
- Production blue/green + OIDC account separation

Xem lại [Security & deployment](../../docs/architecture/security-deployment.md) khi lên pilot/prod.
