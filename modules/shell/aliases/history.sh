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

function qh-find-X() {
    cat "$CUSTOM_HISTORY_FILE" | grep -a $1 | highlight yellow ';' | highlight green cd
}

function qh-find-here-anything() {
    bn=$(basename $PWD)
    qh-find-X "$bn" | highlight blue "$bn"
}

