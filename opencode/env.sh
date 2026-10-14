# 供 source 使用：DeepSeek（OpenCode 原生 provider，API 直连、不走 Mihomo）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY ALL_PROXY all_proxy

for LOCAL_ENV in "$REPO_ROOT/env/.env.opencode.local" "$REPO_ROOT/env/.env.claude.local"; do
  if [[ -f "$LOCAL_ENV" ]]; then
    set -a
    # shellcheck disable=SC1090
    source "$LOCAL_ENV"
    set +a
  fi
done

export DEEPSEEK_API_KEY="${DEEPSEEK_API_KEY:-}"
export OPENCODE_CONFIG="${OPENCODE_CONFIG:-$SCRIPT_DIR/opencode.deepseek.json}"
export OPENCODE_MODEL="${OPENCODE_MODEL:-deepseek/deepseek-flash}"

if [[ -z "${DEEPSEEK_API_KEY:-}" ]]; then
  echo "缺少 DeepSeek API Key：创建 env/.env.opencode.local 或 env/.env.claude.local（见 env/.env.example）" >&2
  return 1 2>/dev/null || exit 1
fi
