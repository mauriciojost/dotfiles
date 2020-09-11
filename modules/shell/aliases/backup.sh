function qbackup-locals() {
  local d=`mktemp --directory`
  cd $d
  git clone $LOCALS_BACKUP_GIT_REPO 
  cd $LOCALS_BACKUP_GIT_REPO_DIR
  cp \
    $HOME/.localrc \
    $CUSTOM_HISTORY_FILE \
    $HOME/.bash_history \
    $HOME/.config/google-chrome/Default/Bookmarks \
    .
  git add -A && git commit -m "Backup" && git push
}

alias backup=qbackup-locals
