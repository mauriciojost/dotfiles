function qfzf_cd_with() {
  cd "$(find . -maxdepth 3 -type d 2>/dev/null | fzf --preview="tree -L 2 {}" --bind="space:toggle-preview")"
}

function qfzf_vim_with() {
  echo vim "$(find . -type f 2>/dev/null | fzf --preview="head -100 {}" --bind="space:toggle-preview")"
}

function qfzf_history_with() {
  cat $CUSTOM_HISTORY_FILE | fzf
}

