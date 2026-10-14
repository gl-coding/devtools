#!/usr/bin/env bash
# 安装 OpenCode CLI（需 Node.js；npm 若需代理请自行 export 后再运行）
set -euo pipefail

if ! command -v node >/dev/null 2>&1; then
  echo "请先安装 Node.js（建议 >= 18）" >&2
  exit 1
fi

echo "安装 opencode-ai（建议 >= 1.18.30）..."
npm install -g opencode-ai
opencode --version
echo "完成。配置 Key：env/.env.claude.local 或 env/.env.opencode.local，然后 ./devtools/opencode/run.sh"
