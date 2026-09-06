# Orca-Kernel

基于 Orca 的有限范围二开：复用会话、Worktree、任务、消息与恢复能力，补充任务契约、执行准入和成果验收。当前只推进 v0.1。

本仓库保存项目执行依据、接手记录和 v0.1 最小计划规则的开发分支；尚未引入 Orca 完整源码，也未接入受管运行功能。GitHub 上它是私有独立仓库，不是 `stablyai/orca` 的 Fork；现有 LICENSE 不替代将来引入上游时应保留的许可与来源。

- [执行手册与唯一看板](V01-TODO.md)：每次先读当前关卡、入口条件与放行记录。
- [版本功能路线图](docs/ROADMAP-2026-09-06.md)：用户提供的规划原文，后续版本不代表本轮范围。
- [G00 接手与环境盘点](docs/G00-HANDOFF.md)：本轮证据、保护范围、备份方案和待解决事项。

两份规划冲突时，v0.1 执行以两组对照版手册为准：CURRENT 与 KERNEL，共 12 次主实验；CODEX 默认不执行，仅为可选独立参照；上游 U 冒烟不计入比较组。路线图第十四节的多组比较仅保留为历史规划，不增加本轮负担。

当前环境决定为 Docker-first：Windows 日常 Orca 保持原状，实验 Orca/Codex、非 root HOME、记忆副本和目标仓库在容器内；VM 只作备选，不要求 Windows 换用户。CURRENT 正式定义为一条当前生效的内置提示词、长期记忆及其提示词钩子，加 Orca 1.4.188 基础设施与惯常操作；不寻找独立 Kit。

固定 v1.4.188 Linux 包已下载并通过官方 SHA256 校验。当前推进未修改 Orca 的容器启动、Worker、结果和停止技术冒烟；具体状态、证据及阻塞只更新 [V01-TODO.md 的当前任务](V01-TODO.md)。G00/G03 未自动通过；按真实依赖推进独立源码开发和纯规则测试，G04 完整 CURRENT 复现约束正式比较。

[固定发行包续传脚本](scripts/resume-orca-download.ps1) 的完成结果保留在实验下载目录 `resume-download.log`。实验容器使用 [Compose](compose.yaml) 和 [Dockerfile](docker/Dockerfile)，只读取指定发行包构建上下文，不挂载日常 HOME、仓库或 Docker socket。启动说明随实际验证补入现有看板。

当前没有产品安装或 Orca 全仓构建入口。规则分支的真实验证入口为 `node --test tests/kernel/plan.test.ts`（Node 24）；它只验证计划纯规则，不代表真实派发、停止、整合或 v0.1 完成。
