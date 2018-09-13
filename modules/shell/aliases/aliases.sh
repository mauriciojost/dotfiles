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

# Save and go to last saved directory
function sd(){
    pwd > ~/.last-dir$1
}
function gd(){
    cd $(cat ~/.last-dir$1)
}

# Copy creating directory
function qcp() {
  mkdir -p `basedir $2`
  cp $1 $2
}

# Search a file in the current directory or sub directories
function qf(){
    find | grep $1
}

function qcd() {
  ranger --choosedir=$HOME/.rangerdir
  local lastdir=`cat $HOME/.rangerdir`
  cd "$lastdir"
}

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

# Edit an alias that matches a given pattern
function qalias-edit() {
	local ALIAS=$1
	echo "Alias: $ALIAS"
	FILES="`grep $ALIAS -l -R $DOTFILES/modules/shell/aliases/`"
	echo "Found: "
	echo $FILES
	vim $FILES
}

