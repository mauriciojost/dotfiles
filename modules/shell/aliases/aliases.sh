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

function qhelp() {
  local s="$DOTFILES/modules/xfce/xfce4.configlink/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml"
  echo "### GENERAL SHORTCUTS"
  echo "ctrl + space                ulauncher"
  echo ""
  echo "### XFCE SHORTCUTS"
  _xmllint "$s" '/channel[@name="xfce4-keyboard-shortcuts"]/property[@name="commands"]/property[@name="default"]/property[@type!="empty"]'
  _xmllint "$s" "/channel[@name=\"xfce4-keyboard-shortcuts\"]/property[@name=\"commands\"]/property[@name=\"custom\"]/property/@*[name()='name' or name()='value']"
  _xmllint "$s" "/channel[@name=\"xfce4-keyboard-shortcuts\"]/property[@name=\"xfwm4\"]/property[@name=\"custom\"]/property/@*[name()='name' or name()='value']"
  echo ""
  echo "### SHELL BINDINGS"
  _qset_bindings

  echo ""
  echo "### CONFIGURATION APPS"
  echo "Configure using the following applications"
  echo "- keyboard: xfce4-keyboard-settings"
  echo "- window manager: xfwm4-settings"
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
  echo "Binding: $shortcut for $feature"
  bind "$shortcut:$cmd"
}

function _qset_bindings() {
   # The "$(cmd_with_stdout)\e\C-e\er" is a trick to write output into shell rather than executing it, so that it's stored in the history
  _qbind "Quick CD (to chosen dir, CD to it)" '"\C-f"' '"qfzf_cd_with\n"' 
  _qbind "Quick Find (by content in pwd, type vim cmd)" '"\C-a"' '"$(qfzf_here_by_content)\e\C-e\er"' 
  _qbind "Quick Vim (by filename, type vim cmd)" '"\C-v"' ' "$(qfzf_vim_with)\e\C-e\er"'
  _qbind "History++ (by date/dir/command in pwd, type)" '"\C-h"' '"$(qfzf_history_with)\e\C-e\er"'
  _qbind "Chrome Hist. (by url, open)" '"\C-w"' '"$(qfzf_chrome_history_with)\e\C-e\er"'
  _qbind "Topics (by content, copy to clipboard)" '"\C-t"' '"$(qfzf_topics)\e\C-e\er"'
  #C-j forbidden, causes strange behaviour
  _qbind "Documents" '"\C-u"' '"qfzf_docs\n"'
}



