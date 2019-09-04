# Minor customisations to very used commands
alias qdu='du -hs * | sort -h'
alias gop='exo-open'
alias vim='vim -v'
alias top='top -c'
alias htop="htop -u `whoami`"
alias route='route -n'
alias cal='cal -3'
alias octave='octave --force-gui'
alias grep='grep --color=always'

function e () {
	qexplore
}

alias x=exit
alias p='ping 8.8.8.8'

# Put whatever is piped to qclip into the clipboard
alias qclip='xclip -selection clipboard'


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

