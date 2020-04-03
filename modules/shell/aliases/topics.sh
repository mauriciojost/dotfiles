
function qtopic-list() {
  ls -laht $HOME/topics/ | sort -r
  echo "LATEST HERE ^^^ "
}

function qtopic-open-with-filename-x() {
  local files=`find $HOME/topics/ | grep $1`
  vim $files
}

# Edit an alias that matches a given pattern
function qtopic-edit() {
  local ALIAS=$1
  echo "Alias: $ALIAS"
  FILES="`grep $ALIAS -i -l -R $HOME/topics/`"
  echo "Found: "
  echo $FILES
  vim $FILES
}


function qtopic-new-name() {
  local topic="$1"
  echo $HOME/topics/`date +"%Y-%m-%d"`."$topic"
}

function qtopic-new-file(){
  local topic="$1"
  local f=`qtopic-new-name $topic`.md
  vim "$f"
  echo "File: $f"
}

function qtopic-daily(){
  qtopic-new-file "daily"
}

function qtopic-new-dir(){
  local topic="$1"
  local dir=`qtopic-new-name $topic`
  mkdir -p $dir
  ranger $dir
  echo "Directory: $dir"
}
