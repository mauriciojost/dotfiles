function qsecurity-cleanup-history-matching-single() {
  local file="$1"
  local match="$2"
  cat $file | grep -v "$match" > $file.new
  echo "Before: $(wc -l $file) lines"
  echo "After : $(wc -l $file.new) lines"
  echo "rm $file && mv $file.new $file # if fine"
}

function qsecurity-cleanup-history-matching() {
  local match="$1"
  qsecurity-cleanup-history-matching-single "$CUSTOM_HISTORY_FILE" "$match"
  qsecurity-cleanup-history-matching-single "$HOME/.bash_history" "$match"
}
