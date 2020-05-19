
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

function qtopic-new-file-x-with-template-y(){
  local topic="$1"
  local template="$2"
  local f=`qtopic-new-name $topic`.md
  if [ ! -e "$f" ]
  then
    echo "Using template: $template"
    cp "$template" "$f"
  else
    echo "Ignoring template: $template (file already exists)"
  fi
  vim "$f"
  echo "File: $f"
}

alias qtopic-new='qtopic-new-file-x'

function qtopic-daily(){
  qtopic-new-file-x-with-template-y "daily" "$DOTFILES/modules/topics/templates/daily.md"
}

function qtopic-retro(){
  qtopic-new-file-x-with-template-y "retro" "$DOTFILES/modules/topics/templates/retro.md"
}

alias qdaily=qtopic-daily

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

