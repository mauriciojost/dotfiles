function qswap() {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}


alias qfind-dupes=fslint-gui

function qfiles-rename-recursive-lowercase() {
    shopt -s globstar nullglob
    rename 'y/A-Z/a-z/' **/*
}
