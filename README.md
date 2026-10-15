# devtools

可供不同机器与工程复用的本地开发工具脚本（Codex、Claude Code、OpenCode、VS Code 说明等）。

在 privspec 中位于 `common/devtools/`，由 Ubuntu 与 server 菜单共用；也可作为其他工程（如 nginxRouter）的 Git 子模块。独立仓库：[gl-coding/devtools](https://github.com/gl-coding/devtools)。

## 子模块

| 路径 | 仓库 | 说明 |
|------|------|------|
| `mihomo/` | [gl-coding/mihomo](https://github.com/gl-coding/mihomo) | Mihomo 代理（订阅、节点、Geo） |

克隆 privspec 时请初始化嵌套子模块：

```bash
git clone --recurse-submodules git@github.com:gl-coding/privspec.git ~/.privspec
cd ~/.privspec
# 或已有仓库：
git submodule update --init --recursive
```

单独克隆本仓库时同样需要初始化嵌套子模块：

```bash
git clone --recurse-submodules git@github.com:gl-coding/devtools.git
```

## 目录

- `codex/` — OpenAI Codex CLI 包装（`run.sh`、`env.sh`）
- `claude/` — Claude Code 安装与 DeepSeek 配置示例
- `opencode/` — OpenCode CLI
- `vscode/` — 编辑器相关说明
- `mihomo/` — 代理栈（订阅、节点、测速；[系统代理与系统支持](mihomo/README.md#系统代理与系统支持)，含 Ubuntu KDE / GNOME 的 `sp` 菜单使用说明）

## privspec 菜单接入

- Ubuntu 菜单：`user/ubuntu/sh/sp.sh`，工具路径可通过 `DEVTOOLS_DIR` 覆盖。
- 服务器菜单：`user/server/sp-menu.sh`，工具路径可通过 `SERVER_DEVTOOLS_DIR` 覆盖。
- 默认工具路径均为 `~/.privspec/common/devtools/`；nginxRouter 应用位置由 `NGINXROUTER_DIR` 单独配置，默认 `$HOME/nginxRouter`。

Codex 包装脚本在调用者当前目录运行。Claude Code 和 OpenCode 包装脚本会切到 devtools 根目录，并读取该目录 `env/` 下的私有配置；公共变量可由 privspec 加载入口提前导出。各工具具体参数和配置见各自 README。
