
function yarn_retrieve_id() {
  echo $1
}

function yarn_retrieve_log_file_name() {
  app_id="$(yarn_retrieve_id $1)"
  echo "$HOME/.yarn-logs/$app_id.log.gz"
}


function yarn_retrieve_log() {
  export app_id="$(yarn_retrieve_id $1)"
  export log_file="$(yarn_retrieve_log_file_name $1)"

  if [[ -e "$log_file" ]]
  then 
    echo "### File already downloaded: $log_file"
  else
    echo "### File NOT downloaded, downloading: $log_file"
    yarn logs --applicationId $app_id | gzip > $log_file
  fi 
}

function yarn_analyse_log() {
  yarn_cat_log "$1" |  sed 's/[0-9]//g' | grep 'Exception\|Error' | sort | uniq -c
}

function yarn_explore_log() {
  export app_id="$(yarn_retrieve_id $1)"
  export log_file="$(yarn_retrieve_log_file_name $1)"
  yarn_retrieve_log "$app_id"
  vim $log_file
}

function yarn_cat_log() {
  export app_id="$(yarn_retrieve_id $1)"
  export log_file="$(yarn_retrieve_log_file_name $1)"
  yarn_retrieve_log "$app_id"
  zcat $log_file
}

