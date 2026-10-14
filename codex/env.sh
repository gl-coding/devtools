# 供 source 使用：走本机 Mihomo（与 devtools/mihomo/run.sh 一致）
export http_proxy="${http_proxy:-http://127.0.0.1:7890}"
export https_proxy="${https_proxy:-http://127.0.0.1:7890}"
export ALL_PROXY="${ALL_PROXY:-http://127.0.0.1:7890}"

# Codex CLI：解除沙箱 + 按需审批（git push / 重启服务等）
# 用法见 run.sh --git-friendly、resume.sh
codex_git_friendly_args() {
  printf '%s\n' -s danger-full-access -a on-request
}
