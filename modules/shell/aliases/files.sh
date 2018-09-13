
##################### 
### Explore files


# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# Some more ls aliases
alias l='ls -lhtr --time-style="+%Y-%m-%d %H:%M"'
alias ll='ls -lahtr --time-style="+%Y-%m-%d %H:%M"'
alias la='ls -A'

##################### 
### FIND

function qfind-by-name () {
	qassertnotempty "$1" "Arguments: <filename-pattern-to-look-for>"
	find . -name "$1" | xargs -I% readlink -e % 
}

function qgrep-in-all-files() {
	qassertnotempty "$1" "Arguments: <pattern-to-look-for>"
	grep --line-number -R "$1" .
}

function qgrep-in-all-files-case-non-sensitive() {
	qassertnotempty "$1" "Arguments: <pattern-to-look-for>"
	grep --line-number -R -i "$1" .
}

# Grep with context (showing 5 lines above and 5 lines below the match).
alias qgrep-with-context='grep -C 5'


# Grep with context (showing 5 lines above and 5 lines below the match).
alias qgrep-with-context='grep -C 5'
# Grep with context (showing 5 lines above and 5 lines below the match).

# Highlight with different colors some results
alias qhl='highlight green'
alias qhl2='highlight red'
alias qhl3='highlight yellow'

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
