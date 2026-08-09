#!/bin/bash

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name')
effort=$(echo "$input" | jq -r '.effort.level // empty')

used_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
window_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
if [ "$window_size" -gt 0 ] 2>/dev/null; then
  ctx_pct=$(awk -v u="$used_tokens" -v w="$window_size" 'BEGIN { printf "%.0f", (u/w)*100 }')
else
  ctx_pct=0
fi

five=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

cwd=$(echo "$input" | jq -r '.workspace.current_dir')
worktree=$(echo "$input" | jq -r '.worktree.name // empty')

branch=""
if git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
fi

# Colors (bright)
C_RESET="\033[0m"
C_MODEL="\033[1;96m"
C_EFFORT="\033[2;36m"
C_CTX="\033[1;93m"
C_PCT="\033[2;37m"
C_LIMIT="\033[1;95m"
C_BRANCH="\033[1;92m"
C_WT="\033[1;94m"

parts=()

parts+=("$(printf "${C_MODEL}%s${C_RESET}" "$model")")

if [ -n "$effort" ]; then
  parts+=("$(printf "${C_EFFORT}%s${C_RESET}" "$effort")")
fi

parts+=("$(printf "${C_CTX}%s${C_RESET} ${C_PCT}(%s%%)${C_RESET}" "$used_tokens" "$ctx_pct")")

limit_str=""
if [ -n "$five" ]; then
  limit_str="5h:$(printf '%.0f' "$five")%"
fi
if [ -n "$week" ]; then
  if [ -n "$limit_str" ]; then
    limit_str="$limit_str 7d:$(printf '%.0f' "$week")%"
  else
    limit_str="7d:$(printf '%.0f' "$week")%"
  fi
fi
if [ -n "$limit_str" ]; then
  parts+=("$(printf "${C_LIMIT}%s${C_RESET}" "$limit_str")")
fi

if [ -n "$branch" ]; then
  parts+=("$(printf "${C_BRANCH}%s${C_RESET}" "$branch")")
fi

if [ -n "$worktree" ]; then
  parts+=("$(printf "${C_WT}wt:%s${C_RESET}" "$worktree")")
fi

output=""
for p in "${parts[@]}"; do
  if [ -z "$output" ]; then
    output="$p"
  else
    output="$output | $p"
  fi
done

printf '%s\n' "$output"
