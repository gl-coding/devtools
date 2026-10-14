#!/usr/bin/env bash
# 在仓库根目录启动 Claude Code（DeepSeek 后端，见 env.sh）
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
# shellcheck source=env.sh
source "$(dirname "$0")/env.sh"
cd "$ROOT"
if ! command -v claude >/dev/null 2>&1; then
  echo "未找到 claude，请先安装: ./devtools/claude/install.sh 或 npm install -g @anthropic-ai/claude-code" >&2
  exit 1
fi
exec claude "$@"
