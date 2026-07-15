# Template — Threat Model

> **TEMPLATE.** Thay placeholder `{{...}}`; không ghi production secrets hoặc credentials.

[Security architecture](../docs/architecture/security-deployment.md)

## Scope và owners

- System/use case: `{{SYSTEM}}`
- Security owner: `{{OWNER}}`
- Date/review cadence: `{{DATE_AND_CADENCE}}`
- In/out of scope: `{{BOUNDARIES}}`

## Assets

| Asset | Classification | Owner | Impact nếu lộ/sửa/mất |
|---|---|---|---|
| `{{ASSET}}` | `{{CLASSIFICATION}}` | `{{OWNER}}` | `{{IMPACT}}` |

## Actors và trust boundaries

`{{USERS_ADMINS_SERVICES_AGENT_MODEL_PROVIDERS_ATTACKERS_AND_BOUNDARIES}}`

```mermaid
flowchart LR
  U[{{UNTRUSTED_SOURCE}}] --> A[{{AGENT_BOUNDARY}}]
  A --> M[{{MODEL_PROVIDER}}]
  A --> T[{{TOOL_DOMAIN_BOUNDARY}}]
  A --> D[{{DATA_STORES}}]
```

## Threats và abuse cases

| ID | Threat/abuse case | Entry point | Likelihood/impact | Controls | Residual risk/owner |
|---|---|---|---|---|---|
| `{{T-ID}}` | `{{PROMPT_INJECTION_DATA_EXFIL_TOOL_ABUSE_OR_OTHER}}` | `{{PATH}}` | `{{RATING}}` | `{{PREVENT_DETECT_RESPOND}}` | `{{RISK_OWNER}}` |

Kiểm tra tối thiểu: direct/indirect prompt injection, cross-tenant retrieval, confused deputy,
permission bypass, excessive agency, secret leakage, poisoned memory, malicious tool output,
checkpoint tampering, duplicate write, denial of wallet/service và supply-chain compromise.

## Privacy và compliance

`{{LAWFUL_PURPOSE_MINIMIZATION_RETENTION_RESIDENCY_PROVIDER_TERMS}}`

## Verification plan

- [ ] `{{SECURITY_TEST_OR_RED_TEAM_CASE_AND_OWNER}}`
- [ ] Tenant isolation ở DB/cache/vector/log/trace.
- [ ] Tool denial, approval bypass và action-hash tampering.
- [ ] Memory deletion và provider/data egress controls.
- [ ] Incident detection, kill switch và evidence preservation.

## Acceptance

`{{ACCEPTED_RESIDUAL_RISKS_APPROVERS_DATE}}`
