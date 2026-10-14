# Codex CLI（本仓库运行示例）

OpenAI [Codex CLI](https://developers.openai.com/codex/cli) 在本地终端运行的编程助手。配置与登录状态在 `~/.codex/`，本目录只放**代理环境**和**启动示例**。

## 安装（一次性）

```bash
export http_proxy=http://127.0.0.1:7890 https_proxy=http://127.0.0.1:7890
npm install -g @openai/codex
codex --version
```

若需代理，先启动 `devtools/mihomo/run.sh`。

## 登录（一次性，需交互）

```bash
cd /path/to/nginxRouter
source devtools/codex/env.sh
codex login              # 浏览器 / 设备码登录 ChatGPT
codex login status
codex doctor
```

API Key 方式（可选，勿提交密钥）：

```bash
printenv OPENAI_API_KEY | codex login --with-api-key
```

## 交互式（推荐日常）

在仓库根目录打开 Codex TUI：

```bash
./devtools/codex/run.sh
# 需 git push / 重启服务时：
./devtools/codex/run.sh --git-friendly
# 等价于：source devtools/codex/env.sh && cd 仓库根 && codex -s danger-full-access -a on-request
```

带首条指令进入：

```bash
./devtools/codex/run.sh "简要说明 nginxRouter 的 platform 目录结构"
```

## 非交互 exec

```bash
./devtools/codex/exec.sh "只读：platform/backend/sites/urls.py 里有哪些 mihomo 相关路由"
```

或直接：

```bash
source devtools/codex/env.sh
cd /path/to/nginxRouter
codex exec "运行 platform/backend 里与 db_migrate 相关的测试命令（先说明再执行）"
codex exec review          # 对当前 git 仓库做 code review
codex exec resume --last   # 继续上一次会话（exec 子命令，参数与 resume 不同）

# 恢复交互会话且允许 git push 等（沙箱放宽 + 按需确认）：
./devtools/codex/resume.sh --last
./devtools/codex/resume.sh              # 选择历史
# 等价：codex resume --last --sandbox danger-full-access --ask-for-approval on-request
```

## 常用维护

```bash
source devtools/codex/env.sh
codex doctor
codex update
codex logout               # 清除本机登录
```

## 文件说明

| 文件 | 作用 |
|------|------|
| `env.sh` | 设置 `http_proxy` / `https_proxy` 指向本机 Mihomo `7890` |
| `run.sh` | 仓库根目录 + 代理 + `codex`（可传参） |
| `resume.sh` | 恢复会话（`danger-full-access` + `on-request` 审批，便于 git） |
| `exec.sh` | 仓库根目录 + 代理 + `codex exec "<prompt>"` |
