# devtools

nginxRouter 配套本地开发工具脚本（Codex、Claude Code、OpenCode、VS Code 说明等）。

在 **nginxRouter** 中本目录为 Git 子模块：[gl-coding/devtools](https://github.com/gl-coding/devtools)。

## 子模块

| 路径 | 仓库 | 说明 |
|------|------|------|
| `mihomo/` | [gl-coding/mihomo](https://github.com/gl-coding/mihomo) | Mihomo 代理（订阅、节点、Geo） |

克隆 nginxRouter 时请使用：

```bash
git clone --recurse-submodules git@github.com:gl-coding/nginxRouter.git
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
- `mihomo/` — 代理栈（见该目录 README）
