function cd_with_fzf() {
  cd $HOME 
  cd "$(find . -type d -maxdepth 3 | fzf --preview="tree -L 2 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
}

