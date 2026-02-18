#!/usr/bin/env bash

function ghq-path() {
    ghq list --full-path | fzf
}

function new-session-with-repo() {
# コマンド入力中に押した場合、その入力を一時退避する（キャンセル後に復元されます）
  zle push-line
  
  # コマンドラインに 'tm' をセット
  BUFFER="tm"
  
  # Enterキーを押して実行
  zle accept-line
}

zle -N new-session-with-repo
bindkey '^e' new-session-with-repo

function fzf-z-search() {
  # 1. コマンドラインに何か入力されている場合は、通常のEnterを実行して即終了
  if [[ -n "$BUFFER" ]]; then
    zle .accept-line
    return
  fi

  # 2. 以下は、完全に空の状態でEnterを押した時のみ実行される
  zle -I 
  
  # SC2155対策: 変数の宣言と代入を分ける
  local res
  # SC2259対策: </dev/tty を外し、純粋なパイプにする
  res=$(z | sort -rn | cut -c 12- | fzf)
  
  if [[ -n "$res" ]]; then
    # shellcheck disable=SC2296
    BUFFER="cd ${(q)res}"
    zle .accept-line
  else
    # fzfをキャンセルした場合はプロンプトを綺麗に再描画する
    zle reset-prompt
  fi
}

zle -N fzf-z-search
bindkey "^w" fzf-z-search

function fbr() {
  local branches branch
  branches=$(git branch -a) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

zle -N fbr
bindkey '^b' fbr

function fzf-select-history() {
    # BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
    BUFFER=$(history -n -r 1 | awk '!a[$0]++' | fzf --query "$LBUFFER" --reverse)
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

function memo () {
    vim --cmd 'cd ~/memos' ~/memos/`memof $1`
}

function memos () {
    vim --cmd 'cd ~/memos' ~/memos/
}

function memof () {
    echo `date +%F``echo $1 | sed 's/^\(.\)/-\1/'`.md
}

function sshdockercontainer() {
  docker ps --quiet
  docker exec -it `docker ps --format "{{.Names}}" | fzf` bash
}

alias sdc=sshdockercontainer


# @args: $branch -- target branch name when show diff
# @depended: [git, peco, vimdiff]
function git-select() {
  branch=$1
  file="$(git diff $branch --name-only | sort | fzf)"
  git difftool -t vimdiff $branch -- $file
}

zle -N git-select

