function cd_with_fzf() {
  cd $HOME 
  cd "$(find . -type d -maxdepth 3 | fzf --preview="tree -L 2 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
}

function vim_with_fzf() {
  vim $(fzf)
}

function history_with_fzf() {
  cat $CUSTOM_HISTORY_FILE | fzf
}

