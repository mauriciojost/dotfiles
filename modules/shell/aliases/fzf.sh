function qfzf_cd_with() {
  cd $HOME 
  cd "$(find . -type d -maxdepth 3 | fzf --preview="tree -L 2 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
}

function qfzf_vim_with() {
  local f=$(fzf)
  if [ -z "$f" ]
  then
    vim $(fzf)
  fi
}

function qfzf_history_with() {
  cat $CUSTOM_HISTORY_FILE | fzf
}

