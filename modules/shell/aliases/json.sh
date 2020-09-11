function qjq-all-xpaths() {
  jq -r -c 'path(..)|[.[]|tostring]|join(".")'
}

function qjq() {
  local xpath="$1" # store.book[?(@.price < 10)].title
  python -c "import sys, json, jsonpath; print '\n'.join(jsonpath.jsonpath(json.load(sys.stdin), '$xpath'))"
}

