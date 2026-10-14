#!/usr/bin/env bash
# 恢复 Codex 会话：danger-full-access + on-request（便于 git push 等）
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
exec "$DIR/run.sh" --git-friendly resume "$@"
