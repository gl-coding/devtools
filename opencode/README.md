# OpenCode + DeepSeek

[OpenCode](https://opencode.ai/) 开源终端 / Web AI 编程助手。本目录通过 **DeepSeek 原生 API** 使用模型，密钥放在 `env/.env.opencode.local` 或与 Claude 共用的 `env/.env.claude.local`，不提交 Git。

参考：[DeepSeek × OpenCode](https://api-docs.deepseek.com/quick_start/agent_integrations/opencode/)

## 路径与工作目录

脚本通过自身目录的 `../..` 定位配置根目录，也就是 devtools 的上一级。在 privspec 默认布局中，该目录是 `~/.privspec/common/`，私有配置位于 `common/env/`，不在 `common/devtools/env/`。脚本不会切换调用者的当前目录；OpenCode 的工作区和会话归属由启动时的当前目录决定。下列 `./devtools/...` 和 `env/...` 示例均相对于配置根目录，先执行：

```bash
cd ~/.privspec/common
```

通过统一入口 `source ~/.privspec/load.sh` 加载公共变量后，也可直接用 `sp` 启动；server 的菜单编号见下文。包装脚本仍会切换到上述目录，不保留调用者的当前目录。

## 准备 API Key

在 [DeepSeek 开放平台](https://platform.deepseek.com/) 创建 Key。若已配置 Claude Code，可复用同一文件：

```bash
# 可选：单独文件
cat >> env/.env.opencode.local <<'EOF'
DEEPSEEK_API_KEY=sk-...
EOF
chmod 600 env/.env.opencode.local
```

## 安装

```bash
./devtools/opencode/install.sh
# 或：npm install -g opencode-ai
```

版本建议 **>= 1.18.30**（DeepSeek provider 与 V4-Flash 模型）。

## 启动

```bash
cd ~/.privspec/common
./devtools/opencode/run.sh
```

或终端菜单：`sp` → **8** 新会话、**9** 继续最近、**10** 选择历史（`user.local=server`，见 privspec 的 `user/server/sp-menu.sh`）。

`run.sh` 会加载 `DEEPSEEK_API_KEY`、设置 `OPENCODE_CONFIG`（默认模型 **deepseek/deepseek-flash**），并 **unset 代理变量**（DeepSeek API 直连，不走 Mihomo）。

首次也可在 TUI 内执行 `/connect` → 选 **deepseek** 并粘贴 Key；使用 `run.sh` 时通常只需环境变量即可。

### 会话列表为空？

OpenCode 的会话按 **工程目录** 区分。在 `~` 下直接运行 `opencode session list` 往往没有任何输出（不是卡住，而是该目录下没有会话）。请用：

```bash
./devtools/opencode/run.sh session list
```

通过 `sp` 启动时，新会话默认使用启动 `sp` 时所在的工程目录；例如从 `/home/wakaka/.privspec/common/` 启动时，会话归属该目录，从其他工程启动则归属对应工程。`session list` 与历史会话选择也按当前工程目录筛选。或在 TUI 里用 `/session` 查看、切换。

## 覆盖默认模型

在本地 env 中设置：

```bash
export OPENCODE_MODEL=deepseek/deepseek-v4-pro
```

并在 `opencode.deepseek.json` 中同步修改 `model` / `small_model`，或在 TUI 内切换模型。

## 文件说明

| 文件 | 说明 |
|---|---|
| `env.sh` | 清除代理 + 读取 `env/.env.opencode.local` / `env/.env.claude.local` + `OPENCODE_CONFIG` |
| `run.sh` | 在 devtools 上一级目录启动 `opencode`（支持 `--continue` 等参数） |
| `resume.sh` | 列出本工程会话并编号选择恢复 |
| `install.sh` | 全局安装 `opencode-ai` |
| `opencode.deepseek.json` | 默认 `deepseek/deepseek-flash`（无密钥） |

包装脚本直接透传 OpenCode 参数，不附加 `--standalone`：当前 CLI 不支持该参数，传入会显示帮助并退出，影响 TUI 启动与历史会话列表。

`env.sh` 依次读取工作目录下的 `env/.env.opencode.local`、`env/.env.claude.local`；二者有同名变量时，以后读取的 Claude 配置为准。公共变量也可能在工具启动时被这些文件覆盖。
