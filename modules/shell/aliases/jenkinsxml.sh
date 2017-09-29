function qjenkins_search_jobs_from_containing() {
  local jobs_name_pattern="$1"
  local containing="$2"
  find | grep "$jobs_name_pattern" | grep xml | xargs -I% grep -H "$containing" %
}

function qjenkins_replace_jobs_from_containing_with() {
  local jobs_name_pattern="$1"
  local containing="$2"
  local with="$3"
  find | grep "$jobs_name_pattern" | grep xml | xargs -I% sed -i "s/$containing/$with/g" %
}
