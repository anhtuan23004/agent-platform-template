# Template — Solution Design

> **TEMPLATE, KHÔNG PHẢI CẤU HÌNH THỰC THI.** Thay toàn bộ placeholder dạng
> `{{PLACEHOLDER}}`; xóa hướng dẫn không còn cần trước review.

[Tài liệu kiến trúc](../docs/architecture/index.md)

## Metadata

| Trường | Giá trị |
|---|---|
| Solution | `{{SOLUTION_NAME}}` |
| Owner | `{{OWNER}}` |
| Reviewers | `{{SECURITY_DATA_DOMAIN_REVIEWERS}}` |
| Status/date | `{{DRAFT_OR_APPROVED}}` / `{{YYYY-MM-DD}}` |
| Risk tier | `{{LOW_MEDIUM_HIGH_CRITICAL}}` |

## 1. Problem và outcome

- Problem: `{{PROBLEM_STATEMENT}}`
- Users/process: `{{TARGET_USERS_AND_WORKFLOW}}`
- In scope: `{{IN_SCOPE}}`
- Out of scope: `{{OUT_OF_SCOPE}}`
- Success metrics/baseline: `{{METRICS_WITH_THRESHOLDS}}`
- Human accountability: `{{WHO_OWNS_FINAL_OUTCOME}}`

## 2. Constraints

`{{LEGAL_COMPLIANCE_DATA_RESIDENCY_LATENCY_COST_CONSTRAINTS}}`

## 3. Context và data flow

```mermaid
flowchart LR
  User[{{ACTOR}}] --> Channel[{{CHANNEL}}]
  Channel --> Agent[{{AGENT_APPLICATION}}]
  Agent --> Runtime[{{RUNTIME_ADAPTER}}]
  Agent --> Tools[{{TOOL_DISPATCHER}}]
  Tools --> Domain[{{DOMAIN_SYSTEMS}}]
  Agent --> Stores[{{MEMORY_CHECKPOINT_AUDIT}}]
```

Mô tả trust boundaries, data classification và system of record:
`{{DATA_FLOW_AND_OWNERSHIP}}`

## 4. Agent behavior

- Contract: `{{LINK_TO_AGENT_CONTRACT}}`
- Planning mode: `{{DETERMINISTIC_GRAPH_OR_ADAPTIVE_LOOP}}`
- Tools/effects: `{{TOOLS_AND_RISK}}`
- Memory: `{{MEMORY_SCOPE_AND_POLICY}}`
- HITL/escalation: `{{CHECKPOINTS_AND_APPROVERS}}`
- Budgets: `{{STEPS_TIMEOUT_TOKENS_COST_RATE}}`

## 5. Reliability và recovery

`{{FAILURE_MODES_RETRY_IDEMPOTENCY_COMPENSATION_RECONCILIATION}}`

## 6. Security, privacy và audit

`{{AUTHZ_TENANCY_DLP_RETENTION_AUDIT_THREAT_MODEL}}`

## 7. Observability và evaluation

`{{SLIS_SLOS_TRACES_METRICS_EVAL_DATASETS_ACCEPTANCE_THRESHOLDS}}`

## 8. Deployment và rollout

`{{TOPOLOGY_CAPACITY_CANARY_KILL_SWITCH_ROLLBACK_RUNBOOKS}}`

## 9. Alternatives và decisions

`{{ALTERNATIVES_TRADEOFFS_ADR_LINKS}}`

## 10. Open questions

- [ ] `{{QUESTION_OWNER_DUE_DATE}}`

## Approval

| Role | Name | Decision | Date |
|---|---|---|---|
| Domain | `{{NAME}}` | `{{DECISION}}` | `{{DATE}}` |
| Security | `{{NAME}}` | `{{DECISION}}` | `{{DATE}}` |
| Data/privacy | `{{NAME}}` | `{{DECISION}}` | `{{DATE}}` |
| Operations | `{{NAME}}` | `{{DECISION}}` | `{{DATE}}` |

