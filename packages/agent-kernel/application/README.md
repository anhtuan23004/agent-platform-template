# agent-kernel/application

Agent use cases và lifecycle orchestration. Gọi ports; không import
LangChain/LangGraph trực tiếp.

## Trách nhiệm

- Nạp context tối thiểu theo policy
- Chọn planner/workflow qua ports
- Áp dụng step/token/cost budgets
- Phát canonical stream events ra channel adapters
