function qfzf_cd_with() {
  cd "$(find . -maxdepth 3 -type d 2>/dev/null | fzf --preview="tree -L 2 {}" --bind="space:toggle-preview")"
}

function qfzf_vim_with() {
  echo vim "$(find . -type f ! -name "*.class" ! -path "*/.git/*" 2>/dev/null | fzf --preview="head -100 {}" --bind="space:toggle-preview")"
}

function qfzf_history_with() {
  tac $CUSTOM_HISTORY_FILE | fzf --no-sort
}

function qfzf_chrome_history_with() {
  local backup="/tmp/chrome-history-fzf-search"
  local chrome_history_db="$HOME/.config/google-chrome/Default/History"
  cp "$chrome_history_db" "$backup"
  echo gop $(sqlite3 $backup "select url from urls;" | fzf)
}

