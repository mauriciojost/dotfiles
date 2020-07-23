function qkeep-find() {
  local exp="$1"
  $DOTFILES/modules/keep/keep-cli/keep find --query "$exp"
}

function qkeep-new() {
  local title="$1"
  local text="$2"
  $DOTFILES/modules/keep/keep-cli/keep add --title "$title" --text "$text"
}

