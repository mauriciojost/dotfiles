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
  cd $DOTFILES/docs/spark3
  cat $1 - | spark-shell --packages io.delta:delta-core_2.12:1.0.0 --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" $2
}

qspark-shell-script-spill() {
  qspark-shell-script spill.sc "--executor-memory 1G --driver-memory 1G --executor-cores 1"
}

qspark-shell-script-dataset1-gen() {
  qspark-shell-script dataset1-gen.sc
}

qspark-shell-script-dataset2-gen() {
  cd $DOTFILES/docs/spark3
  mkdir -p datasets
  curl https://raw.githubusercontent.com/opentraveldata/opentraveldata/master/opentraveldata/optd_por_public_all.csv > datasets/optd_por_public_all.csv
  qspark-shell-script dataset2-gen.sc "--driver-memory 2G --driver-cores 4"
}

