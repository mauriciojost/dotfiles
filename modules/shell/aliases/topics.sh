function qtopic(){
  local topic="$1"
  local workspace=`bash -ic qworkspace-getname`
  vim $HOME/topics/`date +"%Y-%m-%d"`."$topic".md
}

function qtopic-dir(){
  local topic="$1"
  local dir=$HOME/topics/`date +"%Y-%m-%d"`."$topic"
  mkdir -p $dir
  ranger $dir
}

