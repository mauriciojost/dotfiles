# 'typical dirs' are considered $PWD, $TOPICS and $DOTFILES/docs

function _typical_dirs() {
  local interm="$1"
  local output="$interm $DOTFILES/docs $interm $TOPICS"
  if [ "$(pwd)" != "$HOME" ] 
  then
    output="$output $interm $(pwd)"
  else
    output="$output"
  fi
  echo "$output"
}
function qfzf_cd_with() {
  cd "$(find $pwd -maxdepth 3 -type d 2>/dev/null | fzf --preview="tree -L 2 {}" --bind="space:toggle-preview")"
}


# Search on typical dirs by filename (not by content) and stdout vim command on choice (search is on typical dirs)
function qfzf_vim_with() {
  echo vim "$(find $(_typical_dirs) -type f ! -name "*.class" ! -path "*/.git/*" 2>/dev/null | fzf --preview="head -100 {}" --bind="left:toggle-preview")"
}

function qfzf_history_with() {
  echo "Useful expression: 'fullword fuzzy 'fullword2" >&2
  tac $CUSTOM_HISTORY_FILE | egrep -a "$(pwd | tr '/' '.')" | fzf --no-sort --tiebreak=end,length,index --keep-right
}

function qfzf_chrome_history_with() {
  local backup="/tmp/chrome-history-fzf-search"
  local chrome_history_db="$HOME/.config/google-chrome/Default/History"
  cp "$chrome_history_db" "$backup"
  echo gop $(sqlite3 $backup "select url from urls;" | fzf)
}

function qfzf_file_path_egrepargs_X_by_filenamecontent() {
  local from="$1"
  f=$(egrep . $from | fzf | awk -F: '{print $1}')
  if [ "$f" != "" ]
  then
    echo "vim $f"
  else
    echo "echo Nothing"
  fi
}

function qfzf_content_egrepargs_X_by_filenamecontent() {
  local args="$1"
  egrep . $args | fzf | awk -F: '{$1=""; print $0}'
}

# Edit an alias that matches a given pattern
function qfzf_alias() {
  qfzf_file_path_egrepargs_X_by_filenamecontent "-r $DOTFILES/modules/shell/aliases/"
}

# Show our documents
#function qfzf_docs() {
#  qfzf_content_egrepargs_X_by_filenamecontent "-r $DOTFILES/docs/" | tr -d '\n' | xclip -selection clipboard
#  echo "Pasted into clipboard!"
#}

# Show our topics
#function qfzf_topics() {
#  qfzf_file_path_egrepargs_X_by_filenamecontent "-r $TOPICS"
#}

# Explore all files in pwd
#function qfzf_here_by_content() {
#  qfzf_file_path_egrepargs_X_by_filenamecontent "-r $(pwd)"
#}

# Search on typical dirs and copy selected line into the clipboard
function qfzf_typical_line_on_clipboard() {
  qfzf_content_egrepargs_X_by_filenamecontent "$(_typical_dirs -r)" | tr -d '\n' | xclip -selection clipboard
  echo "Pasted into clipboard!"
}

# Search on typical dirs by content (and by filename) and stdout vim command on choice (search is on typical dirs)
function qfzf_typical_filename_stdout() {
  qfzf_file_path_egrepargs_X_by_filenamecontent "$(_typical_dirs -r)"
}

