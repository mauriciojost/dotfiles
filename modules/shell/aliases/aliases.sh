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
alias tree='tree -s -h -f --du'
alias tree-nohuman='tree -s -f --du'
alias gopen='thunar'
alias gedit='mousepad'
alias notepad='gedit'

function qhelp() {
    ranger $DOTFILES/docs/
}

function qf(){
    find | grep $1
}

function qalias-edit() {
	export ALIAS=$1
	FILES=`grep $ALIAS -l -R $DOTFILES/modules/shell/aliases/`
	vim $FILES
}

