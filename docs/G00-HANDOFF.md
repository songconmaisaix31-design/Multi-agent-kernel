# G00 接手与环境盘点

日期：2026-09-06（Asia/Shanghai）。运行状态是本轮查询时的快照。

**阅读顺序：** 下方首次盘点保留为历史证据；其 R1/R2 选择、寻找独立 Kit 和整目录冷备份提案，已被本文件后续“Docker-first 补查与用户决定”取代，不再作为当前行动要求。最新关卡状态见文末交接；不得据历史提案复制/挂载整个日常目录。

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

## 首次盘点的阻塞与后续（历史，已由后续决定替代）

- 确认 R1/R2 并准备获准实验身份，检查真实 home、工具及对日常目录的访问边界。当前未进入 G01。
- 确认 K 是已见协议/配置/工具及惯常流程，还是另有 Kit 文件或仓库；记录未知项，不擅自简化 CURRENT。
- 备份需确认目标、范围和停机窗口；额外模型预算在对应关卡批准。本轮未启动新模型任务。
- G01 再确认源码 Fork 的名称、可见性与现有私有规划仓库的关系；不覆盖当前历史或把原生冒烟增加为第三比较组。

## 首次盘点交接（历史）

关卡：G00；状态：阻塞；0/11 关通过。

实际范围：读取两份规划；盘点授权仓库、日常环境与规则来源；形成保护清单和隔离/冷备份方案。

版本：M=Orca 1.4.188；K 部分定位、未冻结；U/C/P 未选择；本仓库初始 SHA 见环境表。

执行证据：上述命令表及本轮工具回执；文档提交由 `git log -1 -- docs/G00-HANDOFF.md` 定位。

结果：只读盘点有实测；隔离未通过；构建、Worker、停止、恢复、回归和 12 次实验均未测。

人工/风险：实验身份待确认，K 尚未完整定位；发现日常 plugins 链接；备份及额外模型预算未批准。

请求：解决 G00 阻塞并由用户放行后进入 G01，不自行跳关。

## Docker-first 补查与用户决定（2026-09-06，当前有效）

本轮从既有 `953282ceed882bb83439e6eea466d314b4cb6cc3`、`docs/g00-project-takeover` 干净工作区继续。仅更新本文件、V01-TODO.md 和 README.md；保留以上历史证据及原始路线图，没有新增规划、容器文件或 Worker。本轮采用用户新定义，不再要求独立 Windows 用户、不寻找 Kit.zip。

### Docker 前置检查

| 检查 | 实际命令 / 证据 | 本轮结论 |
|---|---|---|
| Docker Desktop | 安装程序文件版本查询 | `C:\Program Files\Docker\Docker\Docker Desktop.exe`，4.77.0.228796；已安装，未观察到 Desktop/backend 进程 |
| CLI | 已解析绝对路径下 `docker.exe --version` | 退出 0；29.5.3，build d1c06ef |
| Compose | 同一 CLI 的 `compose version` | 退出 0；v5.1.4 |
| Context | `docker context show`、`context inspect desktop-linux`；仅输出名称与端点类别 | 均成功；desktop-linux，指向本地 npipe；无 DOCKER_HOST/DOCKER_CONTEXT 覆盖。表示配置目标是 Linux Engine，不能当作运行模式实测 |
| Engine | `docker version --format 'client={{.Client.Version}} server={{if .Server}}{{.Server.Version}} os={{.Server.Os}}{{end}}'` | 退出 1，Server 为空：`open //./pipe/dockerDesktopLinuxEngine: The system cannot find the file specified.` 本轮核心阻塞是 Engine 不可达，不是缺 CLI/Compose |
| 服务 | `Get-CimInstance Win32_Service` 筛选 Docker、WSL、vmcompute、LanmanServer | com.docker.service=Stopped/Manual；WSLService=Running/Auto；vmcompute=Running/Manual；LanmanServer=Running/Auto。单凭 Docker 服务停止不诊断 WSL 后端安装失败 |
| WSL | `wsl --version`、`--status`、`--list --verbose` | 均退出 0；WSL 2.7.3.0、内核 6.6.114.1-1、WSLg 1.0.73；默认版本 2；Ubuntu、docker-desktop、kali-linux 均 WSL2/Stopped。只列举，未启动发行版 |
| 编码复核 | 用 ProcessStartInfo、UTF-16 解码同一 WSL 只读命令 | 首次输出因编码乱码，复核后以上版本/状态清晰；未把乱码当 WSL 失败 |
| 虚拟化/资源 | CIM 与 Get-PSDrive | 16 核/32 逻辑处理器，约 31.3 GiB 内存；HypervisorPresent=true、VirtualizationFirmwareEnabled=true；SLAT 查询为 false，存在 hypervisor 时不据此推定固件不支持或要求改 BIOS；C: 空闲约 71.2 GiB，D: 约 190.8 GiB |
| 限额 | `.wslconfig` 是否存在、Docker settings-store 白名单字段 | `.wslconfig` 不存在；Docker 设置中有默认 WSL 集成开启。未查到显式 CPU/内存限制字段，不猜运行限额；Engine 启动后再核验实际资源 |
| 代理/网络 | Windows Internet Settings 白名单布尔值；GitHub 只读查询 | 用户代理开启且已配置，PAC 未配置；未公开代理值。GitHub tag 查询成功但较慢；容器内代理、镜像拉取、DNS、模型服务均未测，不能把宿主成功等同容器联网 |

Docker Windows 官方文档列出 WSL 版本等条件，并说明安装后需启动 Desktop；本轮未执行安装或系统功能命令。当前只需先尝试正常启动已安装 Desktop，没有证据要求提权/重启/重装。[Docker Windows 文档](https://docs.docker.com/desktop/setup/install/windows-install/)、[WSL 后端说明](https://docs.docker.com/desktop/features/wsl/)。

### CURRENT 三项来源定位

路径缩写：日常 home=`C:\Users\DW\.codex`；托管 home=`C:\Users\DW\AppData\Roaming\orca\codex-runtime-home\home`。下表是 Docker-first 初次补查时的记录，当时仅记录来源与元数据。后续用户已确认并允许保存通用执行协议，最新正文与解除事项见文末；记忆、认证和数据库仍未提交 Git。

| 项目 | 已定位的来源及本轮证据 | 触发/导出边界 |
|---|---|---|
| 当前生效的一条内置提示词 | 当前会话具有用户提供的通用执行协议；两处 home 的 AGENTS.md 均为 1776 字节且内容一致。托管 models_cache.json 存在 gpt-6-astra 的 model_messages 元数据；它与 AGENTS.md 是不同来源，不能互相冒充。两份 config.toml 未发现根级指令文件覆盖键；Orca 当前 profile 的已检查 settings 范围未发现一条对应自定义指令正文 | 能确认用户规则文件与模型指令缓存存在；尚不能证明用户所指“一条内置提示词”的精确身份及实际最终选择/注入方式。未导出模型模板或将 AGENTS.md 擅定为完整基线；需确认对应来源，再按支持的方式保存 |
| 长期记忆 | 当前会话提供的记忆指引指向托管 home 的 memories；实测其下有 memory_summary.md、MEMORY.md、raw_memories.md、rollout_summaries/、skills/、extensions/，home 根还有 memories_1.sqlite 及 WAL/SHM。日常 home 也有 memories，但 MEMORY.md/raw_memories.md 与托管内容不相同 | 当前可见记忆来源是托管 home，不能任选日常副本。仅查目录/比较文件是否相同，不导出完整历史或读数据库内容。哪些通用经验应纳入起点、如何排除本轮答案，以及原生数据库/文件的受支持导出与复位方式尚未确认 |
| 提示词钩子 / 记忆触发 | 两份 config.toml 均有 `[features] memories=true`、`[memories] generate_memories=true`、`use_memories=true`；本会话收到按任务相关性读取长期记忆的提示性指引，并实际可读取托管 registry | 配置与提示性指引为可见证据，不代表硬拦截或已验证所有未来 Worker 的原生注入/写回。确切生成器、版本耦合和容器复现路径留待核验；正常更新权限按每次试验实际生效规则记录，不偷偷禁用 CURRENT 原有能力 |

另外，日常 hooks.json 的 hooks 对象无事件，托管 hooks.json 有 8 类 `type=command` 事件。命令只做结构检查：均匹配 Orca hook 调用且未包含 memory 字样；Orca profile 中 agentStatusHooksEnabled=true。该证据只说明存在 Orca 命令 hook，**不证明它是长期记忆提示词钩子**，也不证明命令无其他副作用；本轮未执行这些 hook。托管 plugins→日常 plugins 的 Junction 仍在，容器不得继承该宿主链接。

安装包内 `resources/app.asar.unpacked/out/main/chunks/managed-agent-hook-controls-RcsNtBpP.js:334` 将 AGENTS.md 列为全局指令资源；345 行从系统 homedir 拼出 `.codex`；369 行附近的 `syncCodexGlobalInstructionsIntoManagedHome` 使用 preferCopy 将全局指令同步到 managed home。只读代码与两份相同文件相符，但不证明它就是用户所指模型内置提示词。该代码未把 memories 列入这组资源，因此也不能推断两处记忆自动同步。托管模型缓存的 client_version=0.153.4、model_messages 存在模板与其他指令字段；未输出正文或从缓存拼造实际完整提示词。

### 固定版本资料与最小容器边界

- 安装 app.asar 的 package.json 实读为 orca 1.4.188。只读 `git ls-remote https://github.com/stablyai/orca.git 'refs/tags/v1.4.188' 'refs/tags/v1.4.188^{}'` 成功：tag object=`8e9d661e4f515b17a90e6916ab193367f09f42e9`，peeled commit=`f32ce859047a85a3ea4f507f633604dfbf596a0e`。这只是版本资料定位，不等于确认安装包对应构建或选定 U。
- 已读 [v1.4.188 package.json](https://raw.githubusercontent.com/stablyai/orca/v1.4.188/package.json) 与 [该版本 headless Linux 文档](https://raw.githubusercontent.com/stablyai/orca/v1.4.188/docs/reference/headless-linux-server.md)。文档提供 AppImage 解包、Xvfb 和非 root 运行线索；实际容器正常权限、sandbox、Worker、停止仍未测。文档含 latest/root/对外服务示例，不直接照搬。
- 读取 [该版本配置镜像代码](https://raw.githubusercontent.com/stablyai/orca/v1.4.188/src/main/codex/codex-config-mirror.ts) 可见 system/runtime home 配置传播路径；源码阅读不等于本机或容器隔离通过。一次 codex-home-paths.ts 在线读取返回 Cache miss，未当作已核验。
- G00 放行后才准备最小 Dockerfile、Compose、启动说明；一套 Orca 与其 Worker 在一个实验容器内，复用 Worktree。M 固定 1.4.188，U 另选定完整 SHA；不得用 latest 把 CURRENT 换成另一版。保持 Windows 日常 Orca 原状，不建设每 Agent 一容器调度器。
- 本轮尚未保存可运行基线。后续只按已确认清单保存提示词、通用经验和提示词钩子；每轮独立副本，允许本轮正常记忆更新，下一轮恢复经确认起点。秘密/认证不进 Git、镜像层或公开记录，不挂/复制整个宿主 HOME、日常 Orca、日常仓库、DW/.codex 或 Docker socket。

### Docker-first 初次补查的待办（历史，最新状态见文末）

1. 用当前 Windows 用户正常打开 `C:\Program Files\Docker\Docker\Docker Desktop.exe`，等待 Engine 就绪。保持 Linux/WSL2 目标，不要求换 Windows 账户。本轮仅获准只读检查，因此 Agent 没有启动 Desktop。随后复查 docker version 的 Server、docker info 的 OSType/资源与 Compose；若出现权限、组件或重启提示，记录准确提示再决定，不能自行提权或升级。
2. 确认所指“一条内置提示词”的入口/名称，或确认它是否就是当前通用执行协议；不能将模型指令缓存和 AGENTS.md 默认为同一项。无须提供秘密、token 或 Kit.zip。当前三项定义已接受，这项确认只用于精确保存起点。
3. 提示词和记忆起点的导出/筛选尚未验证；G00 只读范围内不复制活跃数据库或整目录。需先明确正常导出方法及通用经验范围，G01 保存经确认的副本，G03 验证加载和跨轮复位。没有这些证据不宣称 CURRENT 可复现。
4. 没有证据要求安装 Docker/Compose/WSL、启用额外系统功能、管理员操作或 Windows 重启。容器模式实际值、限额、代理/拉取、Linux 同版本包可用性、Codex 认证/原生记忆机制仍待 Engine 就绪及对应关卡检查。VM 保留为有具体运行/复现失败证据后的备选。

### Docker-first 初次补查交接（历史）

当前关卡及状态：G00，阻塞；Docker-first/CURRENT 定义已由用户决定，G03 未开始、未通过。

实际完成：只读 Docker/WSL/资源/代理检查、三项配置来源定位、1.4.188 资料定位；更新现有手册 G00–G04 与环境/基线定义，保留首次证据。

提交与实际验收结果：文档一致性检查与 `git diff --check` 通过；本轮提交用 `git log -1 -- docs/G00-HANDOFF.md` 定位，推送后核对同名远端分支 SHA。Docker CLI/Compose/WSL 查询成功，Engine 连接失败；构建、容器启动、Worker、停止、隔离与复位均未测。

仍在运行的 Worker／未完成事项：本轮未派发 Worker，不停止日常进程；Engine 不可达，精确提示词身份和记忆导出机制待核验。

需要用户作出的决定：先正常启动已安装 Docker Desktop；确认提示词对应入口；后续按真实错误决定是否需要额外环境操作，不自动放行 G00/G03。

文档验证：用 Node 只读比较 HEAD 与当前文本，确认 G05–G10 功能和两组实验段落完全未变、所有关卡子项 ID 保留、G01–G10 仍待开始、G00 仍阻塞；首次环境表/备份提案/命令证据保留且标注失效范围。三个修改文件的本地 Markdown 链接、代码围栏、有限凭据模式检查通过；未新增源文件、Dockerfile、Compose 或另一份规划。以上检查不是功能测试或完整安全审计。

## 提示词确认与 Engine 复查（2026-09-06，最新）

用户在本轮明确确认下方《Codex / Orca CLI 通用执行协议》为正在使用的提示词。消息中的第二份相同内容按重复粘贴处理；CURRENT 起点保存一份，不重复注入，也不更换成模型厂商指令缓存。此确认解除“提示词精确身份未知”，不要求用户再次确认。

已将用户给出的单份文本与日常/托管 home 的 AGENTS.md 比较：仅统一 CRLF/LF 和忽略首尾空白，内容一致。两份日常文件未修改；下面只保存已公开给本会话的通用协议，不附带任何记忆、凭据、模型模板或运行数据。

### 已确认的 CURRENT 提示词正文

```text
Codex / Orca CLI 通用执行协议

先读取当前仓库和用户提供的 TASK、PRD、开发规划及相关文件，确认目标、范围、验收、现有技术栈和可复用内容。任务文件是业务事实源，不自行扩大范围。

小任务由单 Agent 直接完成。只有任务能够按互斥文件路径并行时，才使用 Orca CLI：

- 主 Agent 先生成一页计划，按文件冲突面拆成 2–5 条长期开发轨。
- 每轨固定：1 Agent + 1 Worktree + 1 Branch + 明确 write_paths。
- Worker 可读取全仓，但只能修改自己的 write_paths；跨轨只提交 Handoff。
- 开发、测试、文档和返修由同一个 Worker 持续完成，完成即 commit + push。
- 主 Agent 只维护计划、状态、决策和验收，不写业务代码。
- 所有轨道完成后，派发 1 个集成 Agent 合并；集成 Agent只补少量路由、导入、配置和类型胶水，领域问题退回原 Worker。

始终遵守：

1. 保持现有技术栈和目录，优先复用，不为并行重构项目。
2. 使用完成任务所需的最少 Agent；文件冲突频繁时合并为一轨。
3. 不建设自研调度器、Attempt、Manifest、Hash 或完成证明系统。
4. 不 force push，不覆盖公共历史，不删除无法解释的文件或队友贡献。
5. AI 已生成、Mock 可展示或代码未测试，都不等于功能完成。
6. 核心路径、适用测试和构建未通过，不得宣称完成。
7. 可自行判断的歧义记录为假设，不反复询问；遇到真实阻塞再报告。
8. 每个阶段保留清晰 Commit，最终分支必须 push。

最终只汇报：

- 完成内容；
- 分支与 Commit SHA；
- 验证命令和结果；
- 真实剩余限制；
- 未执行或需要人工完成的操作。
```

### 本轮只读复查结果

| 命令 / 检查 | 实测结果 |
|---|---|
| docker context show / context inspect | desktop-linux；本地 npipe；无 DOCKER_HOST 覆盖 |
| docker version（筛选 Client/Server/OS） | 退出 0；Client=29.5.3，Server=29.5.3，OS=linux；历史管道不可达已解除 |
| docker info（筛选系统与资源） | 退出 0；x86_64、32 CPU、MemTotal=16391360512 字节（约 15.3 GiB）、kernel=6.6.114.1-microsoft-standard-WSL2、driver=overlayfs |
| docker info（代理字段仅输出是否配置） | HTTP/HTTPS/NoProxy 均已配置；不输出代理地址/凭据。容器 DNS、拉取和模型联网仍未测 |
| docker compose version | 退出 0；v5.1.4 |
| wsl --list --verbose（UTF-16 解码） | 退出 0；Ubuntu、docker-desktop 为 Running/WSL2；kali-linux 为 Stopped/WSL2。Agent 本轮没有启动发行版或 Desktop |
| 提示词文本比较 | 用户单份文本与两处 AGENTS.md 在上述换行/首尾空白规范化后相同；交接只保存一份 |

Engine 资源是整个 Docker 后端的可用配置，不是已经分配给未来实验容器的预算。没有创建容器、读取其他容器内容、拉镜像或执行 Worker；不能据此宣布 Orca/Codex 在容器中可运行或已隔离。

### 当前交接

当前关卡及状态：G00，阻塞。提示词身份已确认、Engine 可达性已解决；不重新要求 Windows 实验用户或独立 Kit。

实际完成：保存一份已确认提示词；只读核对 Engine、资源、代理配置和 WSL 状态；更新现有手册/README/交接，保留之前错误与来源调查。

提交与实际验收结果：提示词一致性和文档检查见本轮工具回执；文档提交由 git log -1 -- docs/G00-HANDOFF.md 定位。Engine/Compose/WSL 查询成功；实验构建、容器启动、Worker、停止、隔离和复位仍未测。

仍在运行的 Worker／未完成事项：本轮未派发 Worker。长期记忆通用经验的筛选/一致性导出、提示词记忆钩子的保存方式仍待核验，G00.03 保持未完成；G01/G03 的基线保存与实际复现未执行。

需要用户作出的决定：提示词与 Docker 启动不再需要确认或人工操作。后续只在确需批准导出范围、环境写入或模型运行时按对应关卡处理；当前不自动放行 G00，不把 Docker 可达视为 G03 通过。
