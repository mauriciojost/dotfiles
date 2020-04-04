function qmd_to_confluence() {
  local title="$1"
  local md="$2"
  $DOTFILES/modules/confluencer/markdown_to_confluence "$title" "$md"
}
