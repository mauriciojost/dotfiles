# 'typical dirs' are considered $PWD, $TOPICS and $DOTFILES/docs
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
  cd "$(find $pwd -maxdepth 3 -type d 2>/dev/null | fzf --preview="tree -L 2 {}" --bind="left:toggle-preview")"
}


# Search on typical dirs by filename (not by content) and stdout vim command on choice (search is on typical dirs)
function qfzf_vim_with() {
  echo vim "$(find $(_typical_dirs) -type f ! -name "*.class" ! -path "*/.git/*" 2>/dev/null | fzf --preview="head -100 {}" --bind="left:toggle-preview")"
}

function qfzf_history_with() {
  local f="$(mktemp)"
  # echo "Useful expression: 'fullword fuzzy 'fullword2" >&2
  tac $CUSTOM_HISTORY_FILE | sed "s#$(pwd)#.#g" | sed "s#cd .; ##g" | column -s ';' > "$f"
  cat "$f" | fzf --no-sort --tiebreak=end,length,index --keep-right | sed 's/^[^;]*;//g'
  rm "$f"
}

function qfzf_history_light_with() {
  local f="$(mktemp)"
  tail -50000 $CUSTOM_HISTORY_FILE | tac - | sed "s#$(pwd)#.#g" | sed "s#cd .; ##g" | column -s ';' > "$f"
  cat "$f" | fzf --no-sort --tiebreak=end,length,index --keep-right | sed 's/^[^;]*;//g'
  rm "$f"
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


  echo gop $(cat /tmp/chrome-history-urls.list | fzf)
}

function qfzf_file_path_egrepargs_X_by_filenamecontent() {
  local from="$1"
  f="$(find $from -type f | while IFS= read -r f ; do echo "$f: $(head -200 $f | tr -d '\n' | tr -d '\0')"; done | fzf | awk -F: '{print $1}')"
  if [ "$f" != "" ]
  then
    echo "vim $f"
  else
    echo "echo '# Nothing found'"
  fi
}

function qfzf_content_egrepargs_X_by_filenamecontent() {
  local args="$1"
  egrep . $args | fzf | awk -F: '{$1=""; print $0}'
}

# Edit an alias that matches a given pattern
function qfzf_alias() {
  qfzf_file_path_egrepargs_X_by_filenamecontent "$DOTFILES/modules/shell/aliases/"
}

# Search on typical dirs and copy selected line into the clipboard
function qfzf_typical_line_on_clipboard() {
  qfzf_content_egrepargs_X_by_filenamecontent "$(_typical_dirs -r)" | tr -d '\n' | xclip -selection clipboard
  echo "Pasted into clipboard!"
}

# Search on typical dirs by content (and by filename) and stdout vim command on choice (search is on typical dirs)
function qfzf_typical_filename_stdout() {
  qfzf_file_path_egrepargs_X_by_filenamecontent "$(_typical_dirs "")"
}

