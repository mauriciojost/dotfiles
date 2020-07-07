fzf_searchable_directories="$HOME/.dotfiles $HOME/workspace $HOME/persospace $HOME/topics"

function qfzf_cd_with() {
  cd "$(find $fzf_searchable_directories -maxdepth 3 -type d 2>/dev/null | fzf --preview="tree -L 2 {}" --bind="space:toggle-preview")"
}

function qfzf_vim_with() {
  echo vim "$(find $fzf_searchable_directories -type f ! -name "*.class" ! -path "*/.git/*" 2>/dev/null | fzf --preview="head -100 {}" --bind="space:toggle-preview")"
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

function qfzf_file_path_from_X_by_filenamecontent() {
  local from="$1"
  f=$(egrep . -r "$from" | fzf | awk -F: '{print $1}')
  if [ "$f" != "" ]
  then
    echo "vim $f"
  else
    echo "echo Nothing"
  fi
}

function qfzf_content_from_X_by_filenamecontent() {
  local from="$1"
  egrep . -r "$from" | fzf | awk -F: '{$1=""; print $0}'
}

# Edit an alias that matches a given pattern
function qfzf_alias() {
  qfzf_file_path_from_X_by_filenamecontent "$DOTFILES/modules/shell/aliases/"
}

# Show our documents
function qfzf_docs() {
  qfzf_content_from_X_by_filenamecontent "$DOTFILES/docs/" | tr -d '\n' | xclip -selection clipboard
  echo "Pasted into clipboard!"
}

# Show our topics
function qfzf_topics() {
  qfzf_file_path_from_X_by_filenamecontent "$TOPICS"
}

# Explore all files in pwd
function qfzf_here_by_content() {
  qfzf_file_path_from_X_by_filenamecontent "$(pwd)"
}



