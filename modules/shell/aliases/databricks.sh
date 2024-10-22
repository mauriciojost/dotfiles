# databricks section
function dls() {
  echo "Using profile: $profile (in profile variable)"
  databricks fs ls --profile $profile $1
}

function dlsl() {
  echo "Using profile: $profile (in profile variable)"
  databricks fs ls --profile $profile -l $1
}

function dcat() {
  echo "Using profile: $profile (in profile variable)"
  databricks fs cat --profile $profile $1
}

