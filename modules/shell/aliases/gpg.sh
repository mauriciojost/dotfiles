alias qkey-pair-list='gpg --list-keys'
alias qkey-pair-new='gpg --generate-key'
function qkey-pair-delete() {
  local keyid="$1"
  gpg --delete-secret-keys $keyid
  gpg --delete-keys $keyid
}
function qpass-insert-new () {
  local folder="$1"
  local passname="$2"
  pass insert $folder/$passname
}
