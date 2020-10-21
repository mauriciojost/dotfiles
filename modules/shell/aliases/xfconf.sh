function qxfconf-list-channels() {
  xfconf-query -l
}
function qxfconf-props-for-channel-x() {
  local channels="$@"
  for c in $channels; do xfconf-query -lv -c "${c}" | sed -r -e "s/^/${c} /"; done
}
