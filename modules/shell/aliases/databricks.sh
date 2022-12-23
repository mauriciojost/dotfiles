# databricks section
function dgo() {
  # ensure to create the environment and login to databricks first
  cd $DOTFILES/modules/databricks
  source venv/bin/activate
  echo 'databricks fs ls dbfs:/'
  databricks fs ls dbfs:/
}

function dls() {
  databricks fs ls -l dbfs:$1
}

function dcat() {
  databricks fs cat dbfs:$1
}

function ddread() {
  #set -x
  databricks fs cat dbfs:$1/_delta_log/00000000000000000$2.json | jq --compact-output 'select (.add)    | .add    | {"path": .path, "sizeMb": (round(.size / 1024 / 1024)), "partition": .partitionValues, "action": "add"}'
  databricks fs cat dbfs:$1/_delta_log/00000000000000000$2.json | jq --compact-output 'select (.remove) | .remove | {"path": .path, "sizeMb": (round(.size / 1024 / 1024)), "partition": .partitionValues, "action": "rem"}'
  #set +x
}
