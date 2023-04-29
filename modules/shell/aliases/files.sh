
##################### 
### Explore files

function qexplore() {
  echo "Use better qcd"
  ranger $PWD  
}

function cdm2() {
  cd ../../
}

function cdm3() {
  cd ../../../
}

function cdm4() {
  cd ../../../../
}

function cdm5() {
  cd ../../../../../
}

function qexplore-gui () {
  nautilus --no-desktop $PWD &
}

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto -a'
  alias fgrep='fgrep --color=auto -a'
  alias egrep='egrep --color=auto -a'
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
  local expr="$1"
  qassertnotempty "$expr" "Arguments: <pattern-to-look-for>"
  grep --line-number -R --exclude-dir='*.git*' "$expr" .
  echo "Will open files..."
  sleep 3
  $(which vim) "+/$expr" $(grep -R --exclude-dir='*.git*' --files-with-matches "$expr") # trick to avoid opening vim alias
}

function qgrep-in-all-files-case-non-sensitive() {
  local expr="$1"
  qassertnotempty "$expr" "Arguments: <pattern-to-look-for>"
  grep --line-number -R -i "$expr" .
  echo "Will open files..."
  sleep 3
  $(which vim) "+/$expr" $(grep -R --files-matches "$expr") # trick to avoid opening vim alias
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
  mkdir -p `dirname $2`
  cp $1 $2
}

# Copy creating directory
function qmv() {
  mkdir -p `dirname $2`
  mv $1 $2
}

# Search a file in the current directory or sub directories
function qf(){
  find | grep $1
}

# Show tree in a fancy way
alias qtree='tree -s -h -f --du'

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

function qfind-more-recent-than-date-x() {
  local dt=${1:-'1/30/2017 0:00:00'}
  find . -newermt $dt 
}

function qsplit-file-x-by-separator-y() {
  csplit $1 "/"$2"/" "{*}"
}


function qlines-only-in-file-1() {
  local file1="$1"
  local file2="$2"
  #find lines only in file1
  comm --check-order -23 "$file1" "$file2"
}

function qlines-only-in-file-2() {
  local file1="$1"
  local file2="$2"
  #find lines only in file2
  comm --check-order -13 "$file1" "$file2"
}

function qlines-common-to-both() {
  local file1="$1"
  local file2="$2"
  #find lines common to both files
  comm --check-order -12 "$file1" "$file2"
}

