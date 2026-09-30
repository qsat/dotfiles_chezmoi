#!/bin/sh
# Claude Code のステータスライン。
# stdin の JSON から、モデル名・ディレクトリ・git ブランチ・コンテキスト使用率を 1 行に出す。
# Orca への状態通知は settings.json の statusLine.command 側で行う（Orca が生成した文字列なので、そこから動かさない）。
input=$(cat)

model=$(printf '%s' "$input" | jq -r '.model.display_name // empty')
cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // empty')
used=$(printf '%s' "$input" | jq -r '(.context_window.used_percentage // empty) | floor')

branch=""
[ -n "$cwd" ] && branch=$(git --no-optional-locks -C "$cwd" branch --show-current 2>/dev/null)
dir=$(printf '%s' "$cwd" | sed "s|^$HOME|~|")

# 色: モデル名 シアン / ディレクトリ 青 / ブランチ 緑 / 使用率 黄。値が無い項目は出さない
out=""
[ -n "$model" ]  && out="${out}$(printf '\033[36m%s\033[0m ' "$model")"
[ -n "$dir" ]    && out="${out}$(printf '\033[34m%s\033[0m ' "$dir")"
[ -n "$branch" ] && out="${out}$(printf '\033[32m(%s)\033[0m ' "$branch")"
[ -n "$used" ]   && out="${out}$(printf '\033[33mctx:%s%%\033[0m' "$used")"
printf '%s' "$out"
