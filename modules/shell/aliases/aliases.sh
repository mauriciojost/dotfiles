alias qdu='du -hs * | sort -h'
alias gop='gnome-open'
alias vim='vim -v'
alias top='top -c'
alias htop="htop -u `whoami`"
alias route='route -n'
alias cal='cal -3'
alias octave='octave --force-gui'
alias b='cd ..'
alias c='cd '
alias r='readlink -e '
alias sd='pwd > ~/.last-dir'
alias gd='cd $(cat ~/.last-dir)'

function qalias() {
    echo "DEPRECATED: Better use qaliases-edit and once over the aliases directory type :grep <tosearch>"
    sleep 1
}

