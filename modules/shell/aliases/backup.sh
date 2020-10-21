function qbackup-locals() {
  local d=`mktemp --directory`
  cd $d
  git clone $LOCALS_BACKUP_GIT_REPO 
  cd $LOCALS_BACKUP_GIT_REPO_DIR
  for c in xfwm4 xfce4-panel xfce4-power-manager xsettings
  do
    qxfconf-props-for-channel-x $c > $HOME/.local.$c.xfconf
  done
  cp \
    $HOME/.local* \
    $CUSTOM_HISTORY_FILE \
    $HOME/.bash_history \
    $HOME/.config/google-chrome/Default/Bookmarks \
    .
  git add -A && git commit -m "Backup" && git push
}

alias backup=qbackup-locals
