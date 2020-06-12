# Minor customisations to very used commands
alias qdu='du -hs * | sort -h'
alias gop='exo-open'
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

function qopen-by-content-cmd-X-dir-Y() {
  local cmd="$1"
  local from="$2"
  $cmd $(egrep . $from | fzf | awk -F: '{print $1}')
}

# Edit an alias that matches a given pattern
function qalias-edit() {
  local alias="$1"
  if [ "$alias" == "" ]
  then
    qopen-by-content-cmd-X-dir-Y vim "$DOTFILES/modules/shell/aliases/*" 
  else
    echo "Alias: $alias"
    files="`grep $alias -l -R $DOTFILES/modules/shell/aliases/`"
    echo "Found: "
    echo $files
    vim $files
  fi
}

