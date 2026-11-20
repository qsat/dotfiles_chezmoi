#!/usr/bin/env bash
# tmux のセッションのほかのウィンドウのペイン（zsh も含む）を、すべて 1 つのウィンドウに移して tiled で並べる。
# 引数はまとめる先のウィンドウの id。無ければ（skhd から呼んだとき）、ws が --from-app で操作するクライアント
# （最初につながった Ghostty のウインドウ。無ければ最後に操作したクライアント）が表示しているウィンドウ
set -euo pipefail

first_ghostty_client() {
  tmux list-clients -F '#{client_created} #{client_termname} #{client_name}' | awk '$2 == "xterm-ghostty"' | sort -n | head -1 | cut -d' ' -f3
}

most_recent_client() {
  tmux list-clients -F '#{client_activity} #{client_name}' | sort -rn | head -1 | cut -d' ' -f2
}

target="${1:-}"
if [[ -z "$target" ]]; then
  client=$(first_ghostty_client)
  [[ -n "$client" ]] || client=$(most_recent_client)
  [[ -n "$client" ]] || exit 0
  target=$(tmux display-message -p -c "$client" '#{window_id}')
fi

# 移す先を毎回「最後のペイン」にすると元の順のまま並び、1 回ごとに tiled にすると pane too small で失敗しない
for p in $(tmux list-panes -s -t "$target" -F '#{window_id} #{pane_id}' | awk -v w="$target" '$1 != w {print $2}'); do
  last=$(tmux list-panes -t "$target" -F '#{pane_id}' | tail -1)
  tmux join-pane -d -s "$p" -t "$last" && tmux select-layout -t "$target" tiled
done
