#!/usr/bin/env bash
# 在调用者当前工程内选择并恢复 OpenCode 会话
set -euo pipefail
# shellcheck source=env.sh
source "$(dirname "$0")/env.sh"

if ! command -v opencode >/dev/null 2>&1; then
  echo "未找到 opencode，请先安装: ./devtools/opencode/install.sh" >&2
  exit 1
fi

json="$(opencode session list --format json 2>/dev/null || echo '[]')"
mapfile -t _rows < <(
  JSON="$json" python3 <<'PY'
import json, os
raw = os.environ.get("JSON", "[]")
try:
    sessions = json.loads(raw)
except json.JSONDecodeError:
    sessions = []
if not isinstance(sessions, list):
    sessions = []
for i, s in enumerate(sessions, start=1):
    sid = s.get("id", "")
    title = (s.get("title") or "(无标题)").replace("\n", " ")
    print(f"{i}\t{sid}\t{title}")
PY
)

if [[ ${#_rows[@]} -eq 0 ]]; then
  echo "当前工程（$PWD）下没有 OpenCode 会话。可先运行: ./devtools/opencode/run.sh"
  exit 0
fi

printf '%s\n' 'OpenCode 历史会话：'
while IFS=$'\t' read -r num sid title; do
  printf '  %s) %s\n' "$num" "$title"
done <<< "$(printf '%s\n' "${_rows[@]}")"

printf '  0) 取消\n'
read -r -p '请选择会话编号 [0-%s]：' pick || exit 0
[[ -z "$pick" || "$pick" == 0 ]] && exit 0

session_id=""
while IFS=$'\t' read -r num sid title; do
  if [[ "$num" == "$pick" ]]; then
    session_id="$sid"
    break
  fi
done <<< "$(printf '%s\n' "${_rows[@]}")"

if [[ -z "$session_id" ]]; then
  echo "无效编号：$pick" >&2
  exit 1
fi

exec opencode --session "$session_id"
