function qx-stop() {
    sudo service lightdm stop
}

function qx-start() {
    sudo service lightdm start
}

function qalias() {
    export ALIASF=/tmp/aliases-tmp
    alias > $ALIASF
    typeset -f >> $ALIASF
    less $ALIASF
    rm $ALIASF
}

