#!/usr/bin/env bash
# 非交互执行示例包装：./exec.sh "你的任务描述"
set -euo pipefail
# shellcheck disable=SC1091
source "$(dirname "$0")/env.sh"
if [[ $# -lt 1 ]]; then
  echo "用法: $0 \"<prompt>\"" >&2
  echo "示例: $0 \"列出 platform/backend 下所有 urls.py\"" >&2
  exit 1
fi
exec codex exec "$@"
