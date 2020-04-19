# Edit an doc that matches a given pattern
function qdoc-open-with-content-x() {
  local content="$1"
  echo "Content: $content"
  local files="`grep $content -i -l -R $DOCS`"
  echo "Found: "
  echo $files
  vim $files
}
