#!/usr/bin/env bash
# 在调用时的当前目录启动 Codex CLI（需已安装：npm install -g @openai/codex）
set -euo pipefail
# shellcheck disable=SC1091
source "$(dirname "$0")/env.sh"
if ! command -v codex >/dev/null 2>&1; then
  echo "未找到 codex，请先安装: npm install -g @openai/codex" >&2
  exit 1
fi

GIT_FRIENDLY=0
if [[ "${1:-}" == "--git-friendly" ]]; then
  GIT_FRIENDLY=1
  shift
fi

if [[ "$GIT_FRIENDLY" -eq 1 ]]; then
  # shellcheck disable=SC2207
  _codex_git_flags=($(codex_git_friendly_args))
  exec codex "${_codex_git_flags[@]}" "$@"
fi

exec codex "$@"
