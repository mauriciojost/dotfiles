function qspark-shell-with-packages() {
  local packs_coords_list=${1:-"com.beachape:enumeratum_2.12:1.5.15"}
  spark-shell --packages "$packs_coords_list"
}

function qspark-shell-with-delta() {
  # assumes spark 3
  cd $DOTFILES/docs/spark3
  spark-shell --packages io.delta:delta-core_2.12:1.0.0 --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension"
}

qspark-shell-script() {
  local script="$1"
  cd $DOTFILES/docs/spark3
  local args=$(cat $script | grep '// Arguments: ' | sed 's#// Arguments: ##g')
  cat $script - | spark-shell --packages io.delta:delta-core_2.12:1.0.0 --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" $args
}

qspark-shell-script-dataset2-download() {
  cd $DOTFILES/docs/spark3
  mkdir -p datasets
  curl https://raw.githubusercontent.com/opentraveldata/opentraveldata/master/opentraveldata/optd_por_public_all.csv > datasets/optd_por_public_all.csv
  echo "Now launch qspark-shell-script dataset2-gen.sc"
}

