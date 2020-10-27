
function qxfconf-list-channels() {
  xfconf-query -l | grep -v 'Channels:' | xargs
}

function qxfconf-dump-props-for-channel-x() {
  local channels="$@"
  for c in $channels 
  do 
    xfconf-query -lv -c "${c}" | awk -F' ' '{a=$1;$1="";print a"^"$0}'
  done
}

function qxfconf-dump() {
  for c in $(qxfconf-list-channels)
  do 
    echo "Dumping channel: $c ..."
    qxfconf-dump-props-for-channel-x "$c" > "$DOTFILES/modules/xfconf/xfconf.$c.conf"
  done
}

function qxfconf-load-props-for-channel-x() {
  local channel="$1"
  local propsfile="$2"
  cat $propsfile | while read line
  do
    prop="$(echo $line | awk -F^ '{print $1}' | sed 's/ *$//g' | sed 's/^ *//g' )"
    valu="$(echo $line | awk -F^ '{print $2}' | sed 's/ *$//g' | sed 's/^ *//g' )"
    xfconf-query -v -c "${c}" -p "$prop" -s "$valu"
  done
}

function qxfconf-load() {
  for c in $(qxfconf-list-channels)
  do 
    f="$DOTFILES/modules/xfconf/xfconf.$c.conf"
    echo "Loading channel: $c ($f) ..."
    qxfconf-load-props-for-channel-x "$c" "$f"
  done
}
