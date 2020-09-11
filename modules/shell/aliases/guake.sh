function qguake-load() {
  dconf load /apps/guake/ < $HOME/.dotfiles/modules/guake/guake.conf
}

function qguake-dump() {
  dconf dump /apps/guake/ > $HOME/.dotfiles/modules/guake/guake.conf
}
