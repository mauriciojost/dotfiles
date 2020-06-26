fzf_searchable_directories="$HOME/.dotfiles $HOME/workspace $HOME/persospace $HOME/topics"
function qfzf_cd_with() {
  cd "$(find $fzf_searchable_directories -maxdepth 3 -type d 2>/dev/null | fzf --preview="tree -L 2 {}" --bind="space:toggle-preview")"
}

function qfzf_vim_with() {
  echo vim "$(find $fzf_searchable_directories -type f ! -name "*.class" ! -path "*/.git/*" 2>/dev/null | fzf --preview="head -100 {}" --bind="space:toggle-preview")"
}

function qfzf_history_with() {
  echo "Useful expression: 'fullword fuzzy 'fullword2" >&2
  tac $CUSTOM_HISTORY_FILE | grep "$pwd" | fzf --no-sort --tiebreak=end,length,index --keep-right
}

function qfzf_chrome_history_with() {
  local backup="/tmp/chrome-history-fzf-search"
  local chrome_history_db="$HOME/.config/google-chrome/Default/History"
  cp "$chrome_history_db" "$backup"
  echo gop $(sqlite3 $backup "select url from urls;" | fzf)
}

