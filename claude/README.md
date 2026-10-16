# Claude Code + DeepSeek（devtools/claude）

[Claude Code](https://docs.anthropic.com/en/docs/claude-code) 终端编程助手。本目录通过 **DeepSeek Anthropic 兼容 API** 使用模型，密钥放在 `env/.env.claude.local`，不提交 Git。

参考：[DeepSeek × Claude Code](https://api-docs.deepseek.com/quick_start/agent_integrations/claude_code)

## 路径与工作目录

脚本通过自身目录的 `../..` 定位工作目录，也就是 devtools 的上一级。在 privspec 默认布局中，该目录是 `~/.privspec/common/`，私有配置位于 `common/env/`，不在 `common/devtools/env/`。下列 `./devtools/...` 和 `env/...` 示例均相对于这个工作目录，先执行：

```bash
cd ~/.privspec/common
```

通过统一入口 `source ~/.privspec/load.sh` 加载公共变量后，也可直接用 `sp` 启动；server 的菜单编号见下文。包装脚本仍会切换到上述目录，不保留调用者的当前目录。

## 1. API Key

在 [DeepSeek 开放平台](https://platform.deepseek.com/) 创建 API Key，写入：

```bash
cat >> env/.env.claude.local <<'EOF'
DEEPSEEK_API_KEY=sk-你的密钥
EOF
chmod 600 env/.env.claude.local
```

也可使用 `ANTHROPIC_AUTH_TOKEN=`（与 `DEEPSEEK_API_KEY` 二选一，`env.sh` 会合并）。

## 2. 安装 CLI

需 Node.js；访问 npm / API 建议先启动 Mihomo：

```bash
./devtools/mihomo/run.sh   # 或已在运行
./devtools/claude/install.sh
```

手动安装：

```bash
source devtools/claude/env.sh   # 需已配置 .env.claude.local
npm install -g @anthropic-ai/claude-code
claude --version
```

## 3. 启动

```bash
./devtools/claude/run.sh
# ubuntu_server 的 sp 菜单不提供 Claude Code 入口，需直接运行此脚本。
```

进入后可用 `/status` 确认 **Anthropic base URL** 为 `https://api.deepseek.com/anthropic`。

带首条指令：

```bash
./devtools/claude/run.sh "列出 platform/backend/sites 里与 mihomo 相关的路由"
```

## 4. 持久配置（可选）

`env.sh` 仅对当前 shell 生效。若希望 VS Code 扩展等也走 DeepSeek，可将 `settings.deepseek.json` 中的 `env` 合并进 **`~/.claude/settings.json`**，并把 `ANTHROPIC_AUTH_TOKEN` 设为 Key（勿提交仓库）。

## 5. 文件

| 文件 | 作用 |
|------|------|
| `env.sh` | 代理 + 读取 `env/.env.claude.local` + DeepSeek 模型环境变量 |
| `install.sh` | `npm install -g @anthropic-ai/claude-code` |
| `run.sh` | devtools 上一级目录 + `claude` |
| `settings.deepseek.json` | 可合并到 `~/.claude/settings.json` 的 env 模板（不含密钥） |

## 模型（可覆盖）

| 变量 | 默认 |
|------|------|
| 默认（主模型 / Opus / Sonnet / Haiku / 子 agent） | `deepseek-flash`（DeepSeek-V4.1-Flash，Flash 计价） |

旧名 `deepseek-v4-flash`、`deepseek-v4-flash-vision-exp` 等仍可请求，但已映射到 V4.1-Flash；请优先使用 `deepseek-flash`。

在 `env/.env.claude.local` 中设置 `ANTHROPIC_MODEL` 等即可覆盖。
