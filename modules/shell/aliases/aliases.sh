# Minor customisations to very used commands
alias qdu='du -hs * | sort -h'
alias gop='exo-open'
alias htop="htop -u `whoami`"
alias route='route -n'
alias cal='cal -3'
alias octave='octave --force-gui'
alias grep='grep -a --color=always' # a for binary

alias x=exit

# Put whatever is piped to qclip into the clipboard
alias qclip-to="tr -d '\n' | xclip -selection clipboard -i"
alias qclip-from='xclip -selection clipboard -o'
alias toclip='qclip-to'
alias fromclip='qclip-from'

alias r='readlink -e '

function qopen-by-content-cmd-X-dir-Y-what-Z() {
  local cmd="$1"
  local from="$2"
  local what="$3"

  if [ "$what" == "" ]
  then
    file="$(egrep . -r "$from" | fzf | awk -F: '{print $1}')"
    if [ -e "$file" ]
    then
      $cmd $file
    else
      echo "Bad file: $file"
    fi
  else
    files="$(egrep $what -l -r $from)"
    if [ "$files" != "" ]
    then
      echo "Found files: $files"
      $cmd $files
    else
      echo "No files found."
    fi
  fi

}

# Edit an alias that matches a given pattern
function qalias-edit() {
  qopen-by-content-cmd-X-dir-Y-what-Z vim "$DOTFILES/modules/shell/aliases/" $@
}

alias qalias=qalias-edit

# Show our documents
function qdocs-edit() {
  qopen-by-content-cmd-X-dir-Y-what-Z vim "$DOTFILES/docs/" $@
}

alias qdocs=qdocs-edit


