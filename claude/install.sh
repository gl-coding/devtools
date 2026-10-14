#!/usr/bin/env bash
# 安装 Claude Code CLI（需 Node.js；建议先启动 Mihomo 走 7890）
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
export http_proxy="${http_proxy:-http://127.0.0.1:7890}"
export https_proxy="${https_proxy:-http://127.0.0.1:7890}"
export ALL_PROXY="${ALL_PROXY:-http://127.0.0.1:7890}"

if ! command -v node >/dev/null 2>&1; then
  echo "请先安装 Node.js（建议 >= 18）" >&2
  exit 1
fi

echo "安装 @anthropic-ai/claude-code ..."
npm install -g @anthropic-ai/claude-code
claude --version
echo "完成。配置 Key：cp env/.env.example 中说明，创建 env/.env.claude.local 后执行 ./devtools/claude/run.sh"
