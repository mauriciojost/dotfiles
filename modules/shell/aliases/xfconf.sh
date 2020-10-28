
function qxfconf-list-channels() {
  xfconf-query -l | grep -v 'Channels:' | xargs
}

function qxfconf-dump-props-for-channel-x() {
  local channels="$@"
  for channel in $channels 
  do 
    xfconf-query -lv -c "$channel" | awk -F' ' '{a=$1;$1="";print a"^"$0}' | awk -F'^' '{print $1"^"$2}' | sed 's/\^ /^/g' | sort
  done
}

function qxfconf-dump() {
  for c in $(qxfconf-list-channels | sort)
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
    patString='[a-zA-Z]+'
    patNumber='[0-9]+'
    if [ valu == "true" ] || [ "$valu" == "false" ]
    then
      type=bool
    elif [[ $valu =~ $patString  ]]
    then
      type=string
    elif [[ $valu =~ $patNumber  ]]
    then
      type=int
    else
      type=unknown
    fi
    echo "Loading channel='$channel' property='$prop' value='$valu' (inferred type='$type')"
    xfconf-query -v -c "$channel" -p "$prop" -s "$valu" --create -t $type
  done
}

function qxfconf-reset-props-for-channel-x() {
  local channel="$1"
  qxfconf-dump-props-for-channel-x "$c" | awk -F^ '{print $1}' | while read propname
  do
    xfconf-query -v -c "$channel" -p "$propname" --reset
  done
}

function qxfconf-load() {
  local channels="${1:-$(qxfconf-list-channels)}"
  for c in $channels
  do 
    f="$DOTFILES/modules/xfconf/xfconf.$c.conf"
    if [ -e "$f" ]
    then
      echo "Loading channel: $c ($f) ..."
      qxfconf-load-props-for-channel-x "$c" "$f"
    else
      echo "Skipping channel: $c (no file present) ..."
    fi
  done
}

function qxfconf-reset() {
  local channels="${1:-$(qxfconf-list-channels)}"
  for c in $channels
  do 
    qxfconf-reset-props-for-channel-x "$c"
  done
}
