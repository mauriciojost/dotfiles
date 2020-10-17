alias qexecute-using-local-display="DISPLAY=:0 "

function qhistory-find-x() {
    cat "$CUSTOM_HISTORY_FILE" | grep -a $1
}

