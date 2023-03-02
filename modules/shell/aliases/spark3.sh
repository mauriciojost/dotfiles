function qspark-with-packages() {
  qspark-init
  local packs_coords_list=${1:-"com.beachape:enumeratum_2.12:1.5.15"}
  spark-shell --packages "$packs_coords_list"
}

function qspark-init() {
  cd $DOTFILES/docs/spark3
}

function qspark-with-delta() {
  # assumes spark 3
  qspark-init
  spark-shell --packages io.delta:delta-core_2.12:1.0.0 --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension"
}

function qspark-script() {
  local script="$1"
  qspark-init
  local args=$(cat $script | grep '// Arguments: ' | sed 's#// Arguments: ##g')
  cat $script - | spark-shell --packages io.delta:delta-core_2.12:1.0.0 --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" $args
}

function qspark-script-dataset2-download() {
  qspark-init
  mkdir -p datasets
  curl https://raw.githubusercontent.com/opentraveldata/opentraveldata/master/opentraveldata/optd_por_public_all.csv > datasets/optd_por_public_all.csv
  echo "Now launch qspark-script dataset2-gen.sc"
}

