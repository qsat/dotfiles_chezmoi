#!/usr/bin/env bash
# tmux のセッションのほかのウィンドウのペイン（zsh も含む）を、すべて 1 つのウィンドウに移して tiled で並べる。
# 引数はまとめる先のウィンドウの id。無ければ（skhd から呼んだとき）、最後に操作した tmux クライアントが表示しているウィンドウ
set -euo pipefail

target="${1:-}"
if [[ -z "$target" ]]; then
  client=$(tmux list-clients -F '#{client_activity} #{client_name}' | sort -rn | head -1 | cut -d' ' -f2)
  [[ -n "$client" ]] || exit 0
  target=$(tmux display-message -p -c "$client" '#{window_id}')
fi

# 移す先を毎回「最後のペイン」にすると元の順のまま並び、1 回ごとに tiled にすると pane too small で失敗しない
for p in $(tmux list-panes -s -t "$target" -F '#{window_id} #{pane_id}' | awk -v w="$target" '$1 != w {print $2}'); do
  last=$(tmux list-panes -t "$target" -F '#{pane_id}' | tail -1)
  tmux join-pane -d -s "$p" -t "$last" && tmux select-layout -t "$target" tiled
done
