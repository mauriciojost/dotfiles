function qfzf_cd_with() {
  cd "$(find . -maxdepth 3 -type d 2>/dev/null | fzf --preview="tree -L 2 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
}

function qfzf_vim_with() {
  local f=$(fzf)
  if [ -n "$f" ]
  then
    vim "$f"
  fi
}

function qfzf_history_with() {
  cat $CUSTOM_HISTORY_FILE | fzf
}

