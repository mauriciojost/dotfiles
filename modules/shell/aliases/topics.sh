
function qtopic-list() {
  #ls -laht "$TOPICS"
  find "$TOPICS" -name '*.md' -printf "%T@ %p\n" | sort -n
  echo "LATEST HERE ^^^"
}

function qtopic-last() {
  qtopic-list | tail -16
}

function qtopic-backup() {
  cd "$TOPICS" 
  git add -A
  git commit -a -m "Backup"
  git push origin master
}

function qtopic-open-with-filename-x() {
  local fn="$1"
  local match=""
  if [ -z "$fn" ]
  then
    match="$(find $TOPICS -type f ! -path '*.git*' -printf '%T@^%p\n' | sort -n -r | awk -F^ '{print $2}' | fzf --no-sort)"
  else
    match=`find "$TOPICS" -type f ! -path '*.git*' | grep $fn`
  fi
  if [ -n "$match" ]
  then
    vim $match
  fi
}

# Edit an alias that matches a given pattern
function qtopic-open-with-content() {
  qopen-by-content-cmd-X-dir-Y-what-Z "vim" "$TOPICS" $1
}

function qtopic-new-daily-name() {
  local topic="$1"
  echo $TOPICS/`date +"%Y-%m-%d"`."$topic"
}

function qtopic-new-weekly-name() {
  local topic="$1"
  echo $TOPICS/`date +"%Y-w%V"`."$topic"
}

function qtopic-new-monthly-name() {
  local topic="$1"
  echo $TOPICS/`date +"%Y-m%m"`."$topic"
}

function qtopic-new-daily-file-x(){
  local topic="$1"
  local f=`qtopic-new-daily-name $topic`.md
  vim "$f"
  echo "File: $f"
}

function qtopic-new-weekly-file-x(){
  local topic="$1"
  local f=`qtopic-new-weekly-name $topic`.md
  vim "$f"
  echo "File: $f"
}

function qtopic-new-daily-file-x-with-template-y(){
  local topic="$1"
  local template="$2"
  local f=`qtopic-new-daily-name $topic`.md
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

function qtopic-new-weekly-file-x-with-template-y(){
  local topic="$1"
  local template="$2"
  local f=`qtopic-new-weekly-name $topic`.md
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

function qtopic-new-monthly-file-x-with-template-y(){
  local topic="$1"
  local template="$2"
  local f=`qtopic-new-monthly-name $topic`.md
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

alias qtopic-new='qtopic-new-daily-file-x'

function qtopic-daily(){
  qtopic-new-daily-file-x-with-template-y "daily" "$DOTFILES/modules/topics/templates/daily.md"
}

function qtopic-weekly(){
  qtopic-new-weekly-file-x-with-template-y "weekly" "$DOTFILES/modules/topics/templates/weekly.md"
}

function qtopic-flat(){
  qtopic-new-weekly-file-x-with-template-y "flat" "$DOTFILES/modules/topics/templates/flat.md"
}

function qtopic-monthly(){
  qtopic-new-monthly-file-x-with-template-y "monthly" "$DOTFILES/modules/topics/templates/monthly.md"
}

function qtopic-design-session(){
  qtopic-new-daily-file-x-with-template-y "dessign-session" "$DOTFILES/modules/topics/templates/design-session.md"
}

function qtopic-retro(){
  qtopic-new-daily-file-x-with-template-y "retro" "$DOTFILES/modules/topics/templates/retro.md"
}

function qtopic-investigation(){
  qtopic-new-daily-file-x-with-template-y "investigation-$1" "$DOTFILES/modules/topics/templates/investigation.md"
}

alias qnote=qtopic-new
alias qdaily=qtopic-daily
alias qweekly=qtopic-weekly
alias qmonthly=qtopic-monthly

function qtopic-new-dir-x(){
  local topic="$1"
  local dir=`qtopic-new-daily-name $topic`
  mkdir -p $dir
  ranger $dir
  echo "Directory: $dir"
}

function qtopic-push-to-confluence-file-x() {
  local filename="$1"
  local user="$CONFLUENCE_USERNAME"
  local space='~'"$USER"
  # Below variables must be defined in ~/.localrc, more info at https://github.com/RittmanMead/md_to_conf
  # CONFLUENCE_USERNAME
  # CONFLUENCE_ORGNAME # it's the endpoint without https://
  echo "User: $user, space $space"
  read -sp 'Password: ' pass
  python3 $DOTFILES/modules/md_to_conf/md2conf.py "$filename" "$space" --loglevel debug -u $user -p "$pass"
}

function qtopic-push-to-keep-file-x() {
  local file="$1"
  local filename="$(basename $1)"
  $DOTFILES/modules/keep/keep-cli/keep add --title "KFILE:$filename" --text "$(cat $file)"
}

function qtopic-update-to-keep-file-x() {
  local file="$1"
  local filename="$(basename $1)"
  local id=$($DOTFILES/modules/keep/keep-cli/keep find --query "KFILE:$filename" | grep -v '\[')
  echo $id
  if [ $( echo "$id" | wc -l ) == 1 ]
  then
    echo "One note matched the update request... OK."
	$DOTFILES/modules/keep/keep-cli/keep set --note "$id" --title "KFILE:$filename" --text "$(cat $file)"
  else
    echo "Many notes matching!!! Aborting..."
  fi
}

function qtopic-pull-from-keep-file-x() {
  local file="$1"
  local filename="$(basename $1)"
  local id=$($DOTFILES/modules/keep/keep-cli/keep find --query "KFILE:$filename" | grep -v '\[')
  echo $id
  if [ $( echo "$id" | wc -l ) == 1 ]
  then
    echo "One note matched the update request... OK."
	$DOTFILES/modules/keep/keep-cli/keep get --note "$id" > $file
  else
    echo "Many notes matching!!! Aborting..."
  fi
}

alias qtopic=qtopic-open-with-filename-x

