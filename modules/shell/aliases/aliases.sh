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

# Enter a directory
function c() {
  local target="$1"
  cd "$target"
  ls --color=always
}

alias cd=c
complete -d cd

alias r='readlink -e '

# Save and go to last saved directory
alias sd='pwd > ~/.last-dir'
alias gd='cd $(cat ~/.last-dir)'

# Show tree in a fancy way
alias tree='tree -s -h -f --du'

# Open a file
alias gopen='thunar'

# Open an editor
alias gedit='mousepad'
alias notepad='gedit'

# Show our documents
function qhelp() {
    ranger $DOTFILES/docs/
}

# Search a file in the current directory or sub directories
function qf(){
    find | grep $1
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

