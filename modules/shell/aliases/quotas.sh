function qquota-get-information(){
  repquota -a
}

function qquota-edit-for-user-X(){
  edquota $1
}

function qquota-check(){
  echo a Check all quota-enabled filesystem
  echo v Verbose mode
  echo u Check for user disk quota
  echo g Check for group disk quota
  echo m Forced
  quotacheck -mavug
}
