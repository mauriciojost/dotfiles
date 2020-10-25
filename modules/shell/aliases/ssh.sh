alias qssh-retrieve-public-key-from-private-key='ssh-keygen -y -f ~/.ssh/id_rsa'

function qssh-tunnel-dst-hostX-portY-locportZ() {
  local user_server="$1"
  local dest_port="$2"
  local source_port="$3"
  ssh -N -L "$source_port":127.0.0.1:"$dest_port" "$user_server"
}
