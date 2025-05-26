# 'typical dirs' are considered $PWD, $TOPICS and $DOTFILES/docs
export _HISTORY_MAX_LINES_LIGHT=80000
export _FILE_CONTENT_MAX_FZF=300

export _FZF_HIGHLIGHT="--color='bg:#4B4B4B,bg+:#3F3F3F,info:#BDBB72,border:#6B6B6B,spinner:#98BC99' --color='hl:#44CC44,fg:#D9D9D9,header:#719872,fg+:#D9D9D9' --color='pointer:#E12672,marker:#E17899,header:#98BEDE,hl+:#22FF22'"
alias _fzf="fzf -m $_FZF_HIGHLIGHT --border=sharp"
alias _fzf_editor="vim"
find_args='! -name *.class ! -path *.git*'
function _typical_dirs() {
  local pref="$1"
  local output="$pref $TOPICS"
  echo "$output"
}

function qfzf_cd_with() {
  local query_and_dir="$(find $PWD -maxdepth 2 -type d $find_args 2>/dev/null | _fzf --header="CD TO..." --preview="tree -L 2 {}" --bind="left:toggle-preview" --print-query)"
  local dir_value=$(echo "$query_and_dir" | tail -1)
  local query_value=$(echo "$query_and_dir" | head -1)
  echo "QUERYDIR: $query_and_dir"
  echo "DIR:      $dir_value"
  echo "QUERY:    $query_value"
  if [ -d "$dir_value" ]
  then
    cd "$dir_value"
  else
    new_dir=$(echo $query_value | sed 's/[^0-9a-zA-Z\-]*//g')
    echo "mkdir -p \"$new_dir\" && cd $new_dir"
  fi
}


# Search on typical dirs by filename (not by content) and stdout vim command on choice (search is on typical dirs)
function qfzf_vim_with() {
  echo vim "$(find $(_typical_dirs) -type f $find_args 2>/dev/null | _fzf --header="EDIT..." --preview="head -100 {}" --bind="left:toggle-preview")"
}

# Search on local directory by filename (not by content) and stdout vim command on choice
function qfzf_vim_local_with() {
  echo vim "$(find $(pwd) -type f $find_args 2>/dev/null | _fzf --header="EDIT..." --preview="head -100 {}" --bind="left:toggle-preview")"
}

function qfzf_history_with() {
  # echo "Useful expression: 'fullword fuzzy 'fullword2" >&2
  cat "$CUSTOM_HISTORY_FILE" | _fzf --header="HISTORY..." --tac --no-sort --tiebreak=end,length | sed -E 's/###.*//g'
}

function qfzf_history_light_with() {
  tail -$_HISTORY_MAX_LINES_LIGHT $CUSTOM_HISTORY_FILE | awk -F' ### ' '{print $1}' | tac | awk '!($0 in S) {print; S[$0]}' | tac | _fzf --header="HISTORY($_HISTORY_MAX_LINES_LIGHT)..." --tac --no-sort --tiebreak=end,length
}

function qfzf_history_light_local_with() {
  tail -$_HISTORY_MAX_LINES_LIGHT $CUSTOM_HISTORY_FILE | grep "pwd='$(pwd)'"| awk -F' ### ' '{print $1}' | tac | awk '!($0 in S) {print; S[$0]}' | tac | _fzf --header="HISTORY $PWD ($_HISTORY_MAX_LINES_LIGHT)..." --tac --no-sort --tiebreak=end,length
}

function qfzf_chrome_history_with() {
  local backup="/tmp/chrome-history-fzf-search"
  find $HOME/.config/google-chrome/ $find_args -type f -name History > /tmp/chrome-history-files.list
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
  local find_extra_args="$2"
  local header="$3"
  local query="$4"
  local f="$(find $from -type f $find_args $find_extra_args  | sort -n -r | while IFS= read -r f ; do echo "$f: $(head -$_FILE_CONTENT_MAX_FZF "$f" | tr -d '\n' | tr -d '\0')"; done | _fzf -q "$query" --header="$header" --tiebreak=index --preview='echo -e "FILENAME:{}\n" ; echo {} | cat $(awk -F: "{print \$1}")' --print-query | awk -F: '{print $1}')"
  local query_value=$(echo "$f" | head -1)
  local file_value=$(echo "$f" | tail -1)
  if [ "$file_value" != "" ]
  then
    echo "$file_value"
  else
    echo "$query_value"
  fi
}

function qfzf_content_egrepargs_X_by_filenamecontent() {
  local args="$1"
  local header="$2"
  egrep . $args | _fzf --header="$header" | awk -F: '{$1=""; print $0}'
}

# Edit an alias that matches a given pattern
function qfzf_alias() {
  local f=$(qfzf_file_path_egrepargs_X_by_filenamecontent "$DOTFILES/modules/shell/aliases/" "" "OPEN ALIAS...")
  if [ -f "$f" ]
  then
    echo vim "$f"
  fi
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
  local f=$(qfzf_file_path_egrepargs_X_by_filenamecontent "-E $(_typical_dirs "")" '-maxdepth 1 -regex .+.md' "$header")
  if [ -f "$f" ]
  then
    echo vim "$f"
  fi
}

# Search on this dir by content (and by filename) and stdout vim command on choice (search is on PWD dir recursively)
function qfzf_currdir_filename_stdout() {
  local header="$1"
  local f=$(qfzf_file_path_egrepargs_X_by_filenamecontent "$(pwd)" "-maxdepth 1" "$header")
  if [ -f "$f" ]
  then
    echo vim "$f"
  fi
}

