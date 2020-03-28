
function qtopic-list() {
  ls -laht $HOME/topics/ | sort -r
  echo "LATEST HERE ^^^ "
}

function qtopic-open-with-filename-x() {
  local files=`find $HOME/topics/ | grep $1`
  vim $files
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
