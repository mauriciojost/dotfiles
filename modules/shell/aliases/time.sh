function qtime-hour-to-seconds() {
  local t="$1"
  echo "$t" | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }'
}

function qepoch() {
  date +%s
}

function qtime-epoch() {
  date +%s
}

