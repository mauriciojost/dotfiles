function qdata-avro-read-jsonized() {
  local INPUT=$1
  (echo "val input = \"$INPUT\"" && cat $DOTFILES/modules/avro/read-snippet.sc ) | spark-shell --packages org.apache.spark:spark-avro_2.12:3.2.1 2>&1
}

function qdata-avro-read-raw() {
  local INPUT=$1
  echo 'spark.read.format("avro").load("'$INPUT'").show(1000)' | spark-shell --packages org.apache.spark:spark-avro_2.12:3.2.1 2>&1 | grep '+\||'
}

function qdata-parquet-read-raw() {
  local INPUT=$1
  echo "spark.read.parquet(\"$INPUT\").show(1000)" | spark-shell 2>&1 | grep '+\||'
}
