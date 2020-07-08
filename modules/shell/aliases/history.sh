alias qexecute-using-local-display="DISPLAY=:0 "

function qhistory-find-x() {
    cat "$CUSTOM_HISTORY_FILE" | grep -a $1 | highlight yellow ';' | highlight green cd
}

function qhistory-find-all-in-this-dir() {
    bn=$(basename $PWD)
    qhistory-find-x "$bn" | highlight blue "$bn"
}

