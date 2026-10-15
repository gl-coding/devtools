#!/usr/bin/env bash
# 在仓库根目录启动 OpenCode（DeepSeek，见 env.sh）
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
# shellcheck source=env.sh
source "$(dirname "$0")/env.sh"
cd "$ROOT"
if ! command -v opencode >/dev/null 2>&1; then
  echo "未找到 opencode，请先安装: ./devtools/opencode/install.sh 或 npm install -g opencode-ai" >&2
  exit 1
fi
exec opencode "$@"
