# 'typical dirs' are considered $PWD, $TOPICS and $DOTFILES/docs
export _HISTORY_MAX_LINES_LIGHT=80000
export _FILE_CONTENT_MAX_FZF=300

export _FZF_HIGHLIGHT="--color='bg:#4B4B4B,bg+:#3F3F3F,info:#BDBB72,border:#6B6B6B,spinner:#98BC99' --color='hl:#44CC44,fg:#D9D9D9,header:#719872,fg+:#D9D9D9' --color='pointer:#E12672,marker:#E17899,header:#98BEDE,hl+:#22FF22'"
alias _fzf="fzf $_FZF_HIGHLIGHT --border=sharp"
function _typical_dirs() {
  local pref="$1"
  local output="$pref $TOPICS $pref $DOTFILES/docs"
  if [ "$(pwd)" != "$HOME" ] 
  then
    output="$pref $(pwd) $output"
  else
    output="$output"
  fi
  echo "$output"
}

function qfzf_cd_with() {
  cd "$(find $pwd -maxdepth 3 -type d 2>/dev/null | _fzf --header="CD TO..." --preview="tree -L 2 {}" --bind="left:toggle-preview")"
}


# Search on typical dirs by filename (not by content) and stdout vim command on choice (search is on typical dirs)
function qfzf_vim_with() {
  echo vim "$(find $(_typical_dirs) -type f ! -name "*.class" ! -path "*/.git/*" 2>/dev/null | _fzf --header="EDIT..." --preview="head -100 {}" --bind="left:toggle-preview")"
}

function qfzf_history_with() {
  # echo "Useful expression: 'fullword fuzzy 'fullword2" >&2
  cat "$CUSTOM_HISTORY_FILE" | _fzf --header="HISTORY..." --tac --no-sort --tiebreak=end,length | sed -E 's/###.*//g'
}

function qfzf_history_light_with() {
  tail -$_HISTORY_MAX_LINES_LIGHT $CUSTOM_HISTORY_FILE | _fzf --header="HISTORY($_HISTORY_MAX_LINES_LIGHT)..." --tac --no-sort --tiebreak=end,length | sed -E 's/###.*//g'
}

function qfzf_history_light_local_with() {
  tail -$_HISTORY_MAX_LINES_LIGHT $CUSTOM_HISTORY_FILE | grep "pwd='$(pwd)'"| _fzf --header="HISTORY $PWD ($_HISTORY_MAX_LINES_LIGHT)..." --tac --no-sort --tiebreak=end,length | sed -E 's/###.*//g'
}

function qfzf_chrome_history_with() {
  local backup="/tmp/chrome-history-fzf-search"
  find $HOME/.config/google-chrome/ -type f -name History > /tmp/chrome-history-files.list
  echo "" > /tmp/chrome-history-urls.list
  while IFS= read -r line
  do
    rm -f "$backup"
    cp "$line" "$backup"
    sqlite3 "$backup" "select url from urls;" >> /tmp/chrome-history-urls.list
  done < "/tmp/chrome-history-files.list"


  echo gop $(cat /tmp/chrome-history-urls.list | _fzf)
}

function qfzf_file_path_egrepargs_X_by_filenamecontent() {
  local from="$1"
  local header="$2"
  f="$(find $from -type f | while IFS= read -r f ; do echo "$f: $(head -$_FILE_CONTENT_MAX_FZF "$f" | tr -d '\n' | tr -d '\0')"; done | _fzf --header="$header" | awk -F: '{print $1}')"
  if [ "$f" != "" ]
  then
    echo "vim $f"
  else
    echo "# Nothing found"
  fi
}

function qfzf_content_egrepargs_X_by_filenamecontent() {
  local args="$1"
  local header="$2"
  egrep . $args | _fzf --header="$header" | awk -F: '{$1=""; print $0}'
}

# Edit an alias that matches a given pattern
function qfzf_alias() {
  qfzf_file_path_egrepargs_X_by_filenamecontent "$DOTFILES/modules/shell/aliases/" "OPEN ALIAS..."
}

# Search on typical dirs and copy selected line into the clipboard
function qfzf_typical_line_on_clipboard() {
  local header="$1"
  qfzf_content_egrepargs_X_by_filenamecontent "$(_typical_dirs -r)" "$header" | tr -d '\n' | xclip -selection clipboard
  echo "Pasted into clipboard: '$(xclip -selection clipboard -o)'"
}

# Search on typical dirs by content (and by filename) and stdout vim command on choice (search is on typical dirs)
function qfzf_typical_filename_stdout() {
  local header="$1"
  qfzf_file_path_egrepargs_X_by_filenamecontent "$(_typical_dirs "")" "$header"
}

