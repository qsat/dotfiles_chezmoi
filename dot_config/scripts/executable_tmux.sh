#!/usr/bin/env zsh

set -euo pipefail

function changeSession() {
  local change
  [[ -n "${TMUX:-""}" ]] && change="switch-client" || change="attach-session"
  tmux $change -t "$1"
}

function createSessionIfNeeded() {
  local name=$1
  local dir=${2:-$(pwd)} # $2がない場合は現在のディレクトリ
  
  tmux list-sessions -F "#{session_name}" 2>/dev/null |
    grep -q -E "^${name}$" ||
    tmux new-session -d -c "${dir}" -s "${name}"
}

function selectRepo() {
  local ghq_root=$(ghq root)
  
  # 1. 起動中のtmuxセッション名を配列として取得
  local -a sessions
  sessions=($(tmux list-sessions -F "#{session_name}" 2>/dev/null || true))

  # 2. リストを格納する配列を準備
  local -a active_repos=()
  local -a inactive_repos=()

  # 3. ghq list を1行ずつ読み込んで仕分ける
  while IFS= read -r repo; do
    [[ -z "$repo" ]] && continue
    
    # パスから末尾のリポジトリ名を抽出
    local name="${repo##*/}"
    
    # tmuxの制約に合わせて . を _ に置換して比較
    local safe_name="${name//./_}"
    
    # sessions配列に safe_name が含まれているか（Zsh特有の配列検索）
    if (( ${sessions[(Ie)$safe_name]} )); then
      active_repos+=("* ${repo}")
    else
      inactive_repos+=("  ${repo}")
    fi
  done < <(ghq list)

  # 4. 「起動中」→「未起動」の順に配列を結合
  local -a all_repos
  all_repos+=("${active_repos[@]}")
  all_repos+=("${inactive_repos[@]}")

  # 5. fzf で選択 (キャンセル時のエラーを || true で回避)
  local selected
  selected=$(printf "%s\n" "${all_repos[@]}" | fzf --tiebreak=index --prompt="Select Repo> " || true)

  # 選択された場合のみ処理
  if [[ -n "$selected" ]]; then
    # 先頭2文字 ("* " または "  ") を削除してフルパスを出力
    selected="${selected:2}"
    echo "${ghq_root}/${selected}"
  fi
}

function main() {
  if [ $# -eq 1 ]; then
    createSessionIfNeeded "$1"
    changeSession "$1"
    exit 0
  fi

  local repo="$(selectRepo)"
  
  # fzfでキャンセルされた場合は何もせず終了
  [[ -z "$repo" ]] && return 0

  # リポジトリ名を取得し、tmuxでエラーになる `.` を `_` に置換
  local session="$(basename "$repo" | tr '.' '_')"

  createSessionIfNeeded "$session" "$repo"
  changeSession "$session"
}

main "$@"
