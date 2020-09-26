
function qassertnotempty() {
  if [ -z "$1" ]
  then
    echo "$2" 
    return 1
  fi
}

function echoerr() {
  echo "$@" | perl -ne 'print STDERR'
}


function qshell-check() {
  # apt-get install shellcheck
  local script="$1"
  shellcheck "$script"
}

