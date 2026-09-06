# Orca-Kernel 前期成果归档

正式开发已迁至获准复用的 [公开 Orca Fork：orca-kernel](https://github.com/songconmaisaix31-design/orca-kernel/tree/kernel/v01-managed-dispatch)。后续进度只维护 Fork 内的 [唯一看板](https://github.com/songconmaisaix31-design/orca-kernel/blob/kernel/v01-managed-dispatch/V01-TODO.md)，不在本库建立第二份活跃计划。

本库保留首批计划规则、Node 测试、研究与环境记录。接手时真实 HEAD 为 `08d1ff6b8f2a0df4cce538213d7943508a18e5d2`；其历史和来源提交完整保留。当前 GitHub 实测本库为公开独立仓库，并非 stablyai/orca Fork；本次没有修改可见性、LICENSE 或公共历史。

- [历史手册与验收记录（固定首批 SHA）](https://github.com/songconmaisaix31-design/Multi-agent-kernel/blob/08d1ff6b8f2a0df4cce538213d7943508a18e5d2/V01-TODO.md)
- [原始路线图](docs/ROADMAP-2026-09-06.md)
- [历史环境与 CURRENT 记录](docs/G00-HANDOFF.md)
- [首批接入研究](docs/ORCA-INTEGRATION.md)

原库 `node --test tests/kernel/plan.test.ts` 的 121 条纯规则测试已通过；这不等于 Fork Vitest、TypeScript 检查、受管 Worker 或真实 v0.1 已通过。新的实际结果请看唯一看板。
