# G00 接手与环境盘点

日期：2026-09-06（Asia/Shanghai）。运行状态是本轮查询时的快照。

## 本轮计划与范围

一个 Agent 在当前 checkout 的 `docs/g00-project-takeover` 分支完成接手；write_paths 仅 `README.md`、`V01-TODO.md`、`docs/`。顺序：读任务文件 → 只读盘点 → 保护/隔离提案 → 文档验证 → commit/push。本轮不需要 Worker 或集成 Agent。

用户执行协议已要求最终分支 push，本轮只向现有私有 origin 推送接手文档。未授权新建外部 Fork、安装环境、停机备份或额外模型运行。

## 环境表

| 项目 | 已确认事实 | 限制 / 后续核查 |
|---|---|---|
| 仓库 | `C:\Users\DW\orca\Multi-agent-kernel`；初始 main 与 origin/main 均为 `d5e8c1f4682c969764fcfa170d8fd4ea12117e76`；只有 LICENSE，工作区干净，仅一个 worktree | 无源码、TASK、PRD、package.json；不假定技术栈已经建立 |
| 远端 | `songconmaisaix31-design/Multi-agent-kernel`，PRIVATE，isFork=false，parent=null | G01 需确定真正上游 Fork 的位置，不覆盖现有历史 |
| 系统 | Windows 11 家庭版 中文版，10.0.26200，X64；PowerShell 7.6.5；系统 home=`C:\Users\DW` | 本会话为本机 PowerShell；其他会话是否使用 WSL 未验证 |
| 当前 M / 日常 D | 安装版 Orca 1.4.188，程序 `%LOCALAPPDATA%\Programs\orca\Orca.exe`，CLI 在其 `resources\bin\orca.exe` | M 的源码提交未知；不能以最新 main 或手册研究 SHA 代替 |
| 实例 / userData | state=ready，reachable=true，runtimeId=`90266ef6-5d93-48fe-97a4-927f205a17e1`，PID=31740；与 `%APPDATA%\orca\orca-runtime.json` 的允许字段对应 | 日常 userData 定位为 `%APPDATA%\orca`；未输出认证字段 |
| Agent home | `%USERPROFILE%\.codex` 和 `%APPDATA%\orca\codex-runtime-home\home` 均存在；当前 shell 未设置 CODEX_HOME | 不能由 shell 变量缺失推定 Worker home；G03 实测真实 Worker |
| 已定位 K 来源 | 两处 AGENTS.md 完全相同，均为当前 Codex / Orca CLI 通用执行协议；config.toml 含模型、MCP、插件设置；`%USERPROFILE%\.agents\skills` 存在 | Kit 是否另有仓库、脚本与惯常流程尚未确认；G01 冻结完整 K，G03 核验加载效果 |
| 关键链接 | 托管 home 的 plugins 是 Junction，指向 `%USERPROFILE%\.codex\plugins` | 多 profile 不等于隔离；不能直接复制托管 home 作为干净实验起点 |
| Hooks | 托管配置列出 SessionStart、UserPromptSubmit、PreToolUse、PermissionRequest、PostToolUse、SubagentStart、SubagentStop、Stop；日常 hooks 文件也存在 | 配置存在不证明执行效果或属于 Kit；未输出命令正文 |
| 模型 / 预算 | 两份配置均声明 gpt-6-astra / high；全局 Codex 包元数据为 0.153.4 | 不代表所有运行会话的实际参数；额外冒烟与 12 次实验预算未批准 |
| 工具 | Node v24.16.0；Git 2.47.0.windows.1；pnpm 优先解析到 `%USERPROFILE%\.local\bin\pnpm.ps1`，转调 Corepack | Roaming npm 另有 pnpm 11.8.0；优先包装器实际选择版本未验证，未触发下载/升级；orca-dev、orca-ide 未解析到 |
| 工作负载 | terminal list：14 个终端、14 connected、0 orphaned、未截断；进程查询可见 7 个 Codex 进程 | connected 不等于正在推理；不读取其他任务 preview、不发消息、不停止进程；未审计所有监督任务状态 |
| 资源 | 物理内存约 31.3 GiB；C: 可用约 71.3 GiB，D: 约 190.8 GiB；HypervisorPresent=true | 可用空间变化；该标志不证明已有可用 VM 或可安装某虚拟化产品 |
| 网络 | GitHub 元数据及远端 ref 查询成功 | 模型服务、系统代理、实验身份网络未验证 |
| 环境变量 | 筛选中存在 CODEX_CI、CODEX_SESSION_ID、CODEX_THREAD_ID、HOMEDRIVE、HOMEPATH、USERPROFILE；未发现 ORCA*、WSL*、CODEX_HOME、HTTP_PROXY、HTTPS_PROXY、ALL_PROXY、NO_PROXY | 只记录名称；无进程代理变量不代表没有系统代理；未发现 ORCA_INTERNAL_DEV_SETUP |
| 隔离 | 提案为手册默认 R1：独立非管理员 Windows 用户；亦可由用户选 R2 干净 VM | 已提问，尚无答复；未创建或验证实验身份；本轮日常用户不是获准的完整实验环境 |
| 保护范围 | 日常安装、userData、两处 Agent home、skills/plugins/hooks、凭据、所有已有进程及未指定的业务仓库 | 只对本仓库查 Git 状态；未扫描其他业务仓库。两个外部原始规划文件保持只读 |
| 备份 | 未授权、未执行、未验证恢复 | 本轮 Git 文档提交不等于日常状态备份 |

## 冷备份方案（未执行）

1. 用户安排日常任务退出窗口。届时重新核对 runtime/PID 和其拥有的会话，让任务正常完成、由用户关闭 Orca，核实相关进程树退出。不按名称批量结束 Node/Codex，不沿用本次 PID 直接停止。
2. 建议目标 `D:\OrcaLab-private-backups\2026-09-06-before-kernel\`，尚未创建。先确认源体积、空间和私有访问权限，不能仅因存在 D: 就认定为安全备份盘。
3. 备份范围：日常 `%APPDATA%\orca`、`%USERPROFILE%\.codex`、`%USERPROFILE%\.agents` 及经确认的外部链接目标，另记安装版本/来源。先清点 Junction，不盲目递归或遗漏目标。含认证和会话的备份只留私有位置，不提交 Git，不用作 CURRENT 实验 profile。
4. 确认写入停止后再复制数据库及关联文件。运行中 SQLite 普通复制不是有效冷备份；系统钥匙串/Windows 绑定认证可能不能随文件恢复，必要时正常重新登录，不导出 token。
5. 检查副本完整性、数据库可读性；恢复验证仅在后续批准的隔离位置进行，不覆盖 D，也不直接把副本启动为并存日常实例。

## 验证证据

以下为实际命令与查询结果。对 runtime/config/terminal 数据只输出白名单字段；未保存含凭据、端点或其他任务预览的原始 JSON。

| 命令 / 检查 | 结果 |
|---|---|
| `git status --short --branch`、`git ls-files`、`git log -5 --oneline`、`git worktree list --porcelain` | 成功；初始 main 干净，唯一文件 LICENSE，仅一个 worktree |
| `git rev-parse HEAD`、`git ls-remote origin refs/heads/main` | 成功；初始本地与远端 SHA 一致 |
| `gh repo view songconmaisaix31-design/Multi-agent-kernel --json nameWithOwner,isFork,parent,visibility,defaultBranchRef,url` | 退出 0；PRIVATE、非 Fork、默认 main |
| `Get-Command orca,orca-dev,orca-ide,node,pnpm,git,codex,gh -All -ErrorAction SilentlyContinue` | 已解析命令见环境表；未知命令未启动 |
| 已解析的 `orca.exe skills get orca-cli` | 退出 0，已读本安装版指南 |
| 同一 `orca.exe status --json` | 退出 0；筛选 state/reachable/runtimeId/appVersion/running/pid，版本和实例与环境表一致 |
| 同一 `orca.exe terminal list --json` | 退出 0；仅统计总数/连接/孤立/截断状态，不输出 preview |
| `node --version`、`git --version` | 退出 0；v24.16.0、2.47.0.windows.1 |
| `Get-CimInstance Win32_OperatingSystem` / `Win32_ComputerSystem` / `Win32_Process`、`Get-PSDrive -PSProvider FileSystem` | 查询成功；筛选系统、空间、进程名称/PID/父 PID/路径，未输出进程命令行 |
| 对已定位 home 用 `Get-Item` / `Get-ChildItem` 查看 LinkType/Target；读取两份 AGENTS.md 并精确比较 | 查询成功；plugins Junction 指向日常目录；规则文本一致 |
| 配置白名单值、hooks 事件名、包元数据查询 | 查询成功；仅声明值与结构，不代表真实 Worker 验收 |
| `git diff --cached --check`、本地 Markdown 链接检查、路线图源文件字节比较 | 通过；路线图复制时与源文件逐字节一致，Git 可按现有设置规范换行 |
| `git diff --no-index -- <用户手册原文件> V01-TODO.md` | 退出 1（预期有差异）；人工核对仅 G00 状态、接手说明和 5 项只读/方案勾选变化 |
| 对 4 个交付文件检查常见 GitHub/OpenAI token 与私钥头模式 | 未命中；仅有限模式检查，不构成完整安全审计 |

发现性 `rg --files` 在只有 LICENSE、没有匹配任务/源码文件时返回 1，表示无匹配，不能当成功能测试失败。未找到祖先目录额外的 AGENTS.md；用户 `.codex/AGENTS.md` 和托管规则已读，与会话给定协议一致。

## 阻塞与后续

- 确认 R1/R2 并准备获准实验身份，检查真实 home、工具及对日常目录的访问边界。当前未进入 G01。
- 确认 K 是已见协议/配置/工具及惯常流程，还是另有 Kit 文件或仓库；记录未知项，不擅自简化 CURRENT。
- 备份需确认目标、范围和停机窗口；额外模型预算在对应关卡批准。本轮未启动新模型任务。
- G01 再确认源码 Fork 的名称、可见性与现有私有规划仓库的关系；不覆盖当前历史或把原生冒烟增加为第三比较组。

## 七行交接

关卡：G00；状态：阻塞；0/11 关通过。

实际范围：读取两份规划；盘点授权仓库、日常环境与规则来源；形成保护清单和隔离/冷备份方案。

版本：M=Orca 1.4.188；K 部分定位、未冻结；U/C/P 未选择；本仓库初始 SHA 见环境表。

执行证据：上述命令表及本轮工具回执；文档提交由 `git log -1 -- docs/G00-HANDOFF.md` 定位。

结果：只读盘点有实测；隔离未通过；构建、Worker、停止、恢复、回归和 12 次实验均未测。

人工/风险：实验身份待确认，K 尚未完整定位；发现日常 plugins 链接；备份及额外模型预算未批准。

请求：解决 G00 阻塞并由用户放行后进入 G01，不自行跳关。
