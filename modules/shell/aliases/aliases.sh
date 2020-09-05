# Minor customisations to very used commands
alias qdu='du -hs * | sort -h'
alias gop='exo-open'
alias route='route -n'
alias cal='cal -3'
alias octave='octave --force-gui'
alias grep='grep -a --color=always' # a for binary

alias x=exit

function _xmllint() {
  local f="$1"
  local x="$2"
  xmllint --format "$f" | xmllint --xpath "$x" - | sed 's#name=#\n- #g' | sed 's# value=# ==> #g' | sed -e 's#&..;# #g' | sed 's#"##g' | sed -e 's#&quot;##g'
}

function _xmllint_xfce() {
  local s="$DOTFILES/modules/xfce/xfce4.configlink/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml"
  local x="$1"
  _xmllint "$s" "$x" | grep -v 'override' | sed 's#  # #g'
}


function qhelp() {
  echo "### GENERAL SHORTCUTS" | highlight green '.*'
  echo "ctrl + space                ulauncher" | highlight green '.*'
  echo "" | highlight green '.*'
  echo "### XFCE SHORTCUTS" | highlight red '.*'
  _xmllint_xfce '/channel[@name="xfce4-keyboard-shortcuts"]/property[@name="commands"]/property[@name="default"]/property[@type!="empty"]' | highlight red '.*'
  _xmllint_xfce "/channel[@name=\"xfce4-keyboard-shortcuts\"]/property[@name=\"commands\"]/property[@name=\"custom\"]/property/@*[name()='name' or name()='value']" | highlight red '.*'
  _xmllint_xfce "/channel[@name=\"xfce4-keyboard-shortcuts\"]/property[@name=\"xfwm4\"]/property[@name=\"custom\"]/property/@*[name()='name' or name()='value']" | highlight red '.*'
  echo "" | highlight red '.*'
  echo "### SHELL BINDINGS" | highlight blue '.*'
  _qset_bindings show | highlight blue '.*'
  echo "" | highlight blue '.*'
  echo "### CONFIGURATION APPS" | highlight yellow '.*'
  echo "Configure using the following applications" | highlight yellow '.*'
  echo "- keyboard: xfce4-keyboard-settings" | highlight yellow '.*'
  echo "- window manager: xfwm4-settings" | highlight yellow '.*'
}

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

function _qbind() {
  local feature="$1"
  local shortcut="$2"
  local cmd="$3"
  local mode="$4" # show, set or showset
  if [ "$mode" == "show" ] || [ "$mode" == "showset" ]
  then
    echo "- $shortcut ==> $feature" | sed 's#\\C-#Control #g' | sed 's#"##g'
  fi
  if [ "$mode" == "set" ] || [ "$mode" == "showset" ]
  then
    bind "$shortcut:$cmd"
  fi
}

function _qset_bindings() {
  local mode="$1"
   # The "$(cmd_with_stdout)\e\C-e\er" is a trick to write output into shell rather than executing it, so that it's stored in the history
  _qbind "change Folder (cd ./xx)" '"\C-f"' '"qfzf_cd_with\n"' "$mode"
  _qbind "open typical by fileName to vim" '"\C-n"' ' "$(qfzf_vim_with)\e\C-e\er"' "$mode"
  _qbind "Typical by conTent to vim" '"\C-t"' '"$(qfzf_typical_filename_stdout)\e\C-e\er"' "$mode"
  _qbind "Snippets (typical by content line) to clipboard" '"\C-s"' '"qfzf_typical_line_on_clipboard\n"' "$mode"
  _qbind "History++ (by date/dir/command in pwd, type)" '"\C-h"' '"$(qfzf_history_with)\e\C-e\er"' "$mode"
  _qbind "Chrome Hist. (by url, open)" '"\C-w"' '"$(qfzf_chrome_history_with)\e\C-e\er"' "$mode"
  #C-j forbidden, causes strange behaviour
}



