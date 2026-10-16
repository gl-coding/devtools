#!/usr/bin/env bash
# 在调用者当前工程目录启动 OpenCode（DeepSeek，见 env.sh）
set -euo pipefail
# shellcheck source=env.sh
source "$(dirname "$0")/env.sh"
if ! command -v opencode >/dev/null 2>&1; then
  echo "未找到 opencode，请先安装: ./devtools/opencode/install.sh 或 npm install -g opencode-ai" >&2
  exit 1
fi
exec opencode "$@"
