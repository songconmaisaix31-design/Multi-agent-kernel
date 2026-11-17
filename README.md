# Multi-agent-kernel

`main` holds a license and nothing else: one tracked file, one commit. The work this repository was started for continues in a separate public fork, and the handover note lives on another branch.

`main` 分支只有一个许可文件：一个跟踪文件、一条提交。这个仓库原本要做的事，已经转到另一个公开 fork 继续，交接说明在另一个分支上。

[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Commits on main](https://img.shields.io/badge/commits-1-lightgrey.svg)](https://github.com/songconmaisaix31-design/Multi-agent-kernel/commits/main)
[![Tracked files](https://img.shields.io/badge/tracked_files-1-lightgrey.svg)](https://github.com/songconmaisaix31-design/Multi-agent-kernel)

> **How to read this page · 怎么读这页**
> English first, then the same content in Chinese. This page describes what is verifiable from `main`; claims that come from other branches are attributed to them and marked unverified.
> 每段英文在前，同一内容的中文紧跟在后。本页只写能从 `main` 验证的内容；来自其他分支的说法会注明出处，并标为未验证。

## At a glance · 一眼看懂

| | |
|---|---|
| **What `main` is<br/>main 是什么** | A repository stub: an MIT [LICENSE](LICENSE) and no code.<br/>一个仓库空壳：一份 MIT [LICENSE](LICENSE)，没有代码。 |
| **What exists<br/>已有什么** | One commit, `Initial commit`, dated 2026-09-06.<br/>一条提交 `Initial commit`，日期 2026-09-06。 |
| **Where work continues<br/>工作在哪继续** | A branch note points at a public fork; the next-but-one section lists it.<br/>一个分支上的说明指向公开 fork；下文再下一节列出。 |
| **What is missing<br/>缺什么** | No source, no manifest, no tests, no CI, no build, no releases on `main`.<br/>`main` 上没有源码、依赖清单、测试、CI、构建和发布。 |

## What is on main · main 分支上有什么

One tracked file, one commit, no branches merged in.

一个跟踪文件、一条提交，没有合并其他分支。

```text
Multi-agent-kernel/
└── LICENSE        # MIT, Copyright (c) 2026 DaV1d W · MIT 许可
```

There is no `package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml` or `requirements.txt`; no `src/`, no `tests/`, and no `.github/workflows`. Nothing on `main` can be installed, imported or executed.

没有 `package.json`、`pyproject.toml`、`go.mod`、`Cargo.toml` 或 `requirements.txt`；没有 `src/`、没有 `tests/`、也没有 `.github/workflows`。`main` 上的内容既装不上、也 import 不了、也跑不起来。

## Where the work continues · 工作在哪里继续

The remote carries four branches besides `main`. One of them, `docs/g00-project-takeover`, contains a README written as a handover note; it is not present on `main`.

远端除了 `main` 还有四个分支。其中 `docs/g00-project-takeover` 上有一份作为交接说明的 README，`main` 上没有。

| Branch · 分支 | Role, per its name · 按名字看的作用 |
|---|---|
| `main` | This stub.<br/>本空壳。 |
| `docs/g00-project-takeover` | Handover note and archived early results.<br/>交接说明与早期成果归档。 |
| `songconmaisaix31-design/kernel-v01-rules` | v0.1 rule work.<br/>v0.1 规则相关。 |
| `songconmaisaix31-design/kernel-v01-integration` | v0.1 integration work.<br/>v0.1 集成相关。 |
| `songconmaisaix31-design/kernel-v01-candidate` | v0.1 candidate.<br/>v0.1 候选。 |

That handover note states that development moved to the public fork [orca-kernel](https://github.com/songconmaisaix31-design/orca-kernel), on branch `kernel/v01-managed-dispatch`, and that progress is tracked only there. It also states that this repository keeps the first batch of plan rules, Node tests, research and environment records on its other branches.

那份交接说明称：开发已转到公开 fork [orca-kernel](https://github.com/songconmaisaix31-design/orca-kernel) 的 `kernel/v01-managed-dispatch` 分支，进度只在那里维护；本仓库保留首批计划规则、Node 测试、研究与环境记录。

Both statements come from that branch, not from `main`, and neither is verified here beyond the branch and repository existing. Read them as pointers, then check them before relying on them.

这两条说法来自那个分支，不是来自 `main`；此处除了「分支与仓库确实存在」之外没有验证更多。把它们当作指针，用之前自己核一遍。

Read the note: [branch README](https://github.com/songconmaisaix31-design/Multi-agent-kernel/blob/docs/g00-project-takeover/README.md).

读那份说明：[分支上的 README](https://github.com/songconmaisaix31-design/Multi-agent-kernel/blob/docs/g00-project-takeover/README.md)。

## How to verify · 怎么自己验证

Three read-only commands reproduce every number on this page.

三条只读命令可以复现本页的每个数字。

```bash
git ls-files                     # LICENSE — 1 path · 1 个路径
git rev-list --count HEAD        # 1
git log --oneline                # d5e8c1f Initial commit
git ls-remote --heads origin     # 5 heads, listed above · 5 个分支，见上表
```

The clone used for this page is shallow: `git log` shows one commit because only one was fetched, not because the project has one.

本页使用的克隆是浅克隆：`git log` 只显示一条提交，是因为只取了一条，不是因为这个项目只有一条。

## Status · 状态

A stub with a license. Nothing runs, nothing is tested, and no CI exists on `main`. The project's own note says it is archived rather than active, with development elsewhere.

一个带许可的空壳。`main` 上没有可运行的东西、没有测试、也没有 CI。项目自己的说明写明这里是归档状态，开发在别处进行。

Not implemented on `main`, stated rather than hidden: source code, dependency manifest, tests, continuous integration, releases, and any documentation beyond the license.

`main` 上尚未实现、写出来而不是藏起来的内容：源码、依赖清单、测试、持续集成、发布，以及许可之外的任何文档。

## License · 许可

MIT © 2026 DaV1d W — see [LICENSE](LICENSE).

MIT © 2026 DaV1d W，见 [LICENSE](LICENSE)。
