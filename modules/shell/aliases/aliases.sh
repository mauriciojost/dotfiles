# Minor customisations to very used commands
alias qdu='du -hs * | sort -h'
alias gop='gnome-open'
alias vim='vim -v'
alias top='top -c'
alias htop="htop -u `whoami`"
alias route='route -n'
alias cal='cal -3'
alias octave='octave --force-gui'
alias grep='grep --color=always'

alias r='readlink -e '

# Show our documents
function qhelp() {
    ranger $DOTFILES/docs/
}

# Edit an alias that matches a given pattern
function qalias-edit() {
	local ALIAS=$1
	echo "Alias: $ALIAS"
	FILES="`grep $ALIAS -l -R $DOTFILES/modules/shell/aliases/`"
	echo "Found: "
	echo $FILES
	vim $FILES
}

