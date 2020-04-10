
function qtopic-list() {
  #ls -laht "$TOPICS"
  find "$TOPICS" -name '*.md' -printf "%T@ %p\n" | sort -n
  echo "LATEST HERE ^^^"
}

function qtopic-last() {
  qtopic-list | tail -16
}

function qtopic-open-with-filename-x() {
  local files=`find "$TOPICS" | grep $1`
  echo "Files matched: $files"
  vim $files
}

# Edit an alias that matches a given pattern
function qtopic-open-with-content-x() {
  local content="$1"
  echo "Content: $content"
  local files="`grep $content -i -l -R $TOPICS`"
  echo "Found: "
  echo $files
  vim $files
}

function qtopic-new-name() {
  local topic="$1"
  echo $TOPICS/`date +"%Y-%m-%d"`."$topic"
}

function qtopic-new-file-x(){
  local topic="$1"
  local f=`qtopic-new-name $topic`.md
  vim "$f"
  echo "File: $f"
}

function qtopic-daily(){
  qtopic-new-file-x "daily"
}

function qtopic-new-dir-x(){
  local topic="$1"
  local dir=`qtopic-new-name $topic`
  mkdir -p $dir
  ranger $dir
  echo "Directory: $dir"
}

function qtopic-push-to-confluence-file-x() {
  local filename="$1"
  $DOTFILES/modules/confluencer/markdown_to_confluence "`basename $filename`" "$filename"
}

