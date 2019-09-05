function qhistory-backup() {
    local d=`mktemp --directory`
    cd $d
    git clone $CUSTOM_HISTORY_FILE_BACKUP_GIT_REPO 
    local f=$CUSTOM_HISTORY_FILE_BACKUP_GIT_REPO_DIR/$CUSTOM_HISTORY_FILENAME
    cp $CUSTOM_HISTORY_FILE $f
    cd $CUSTOM_HISTORY_FILE_BACKUP_GIT_REPO_DIR
    git add -A && git commit -m "Backup"
}

alias qexecute-using-local-display="DISPLAY=:0 "

function qh() {
    cat "$CUSTOM_HISTORY_FILE" | highlight yellow ';' | highlight green cd
}

function qhh() {
    bn=$(basename $PWD)
    qh | grep -a "$PWD" | highlight blue "$bn"
}

