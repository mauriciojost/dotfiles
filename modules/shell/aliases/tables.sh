
function qtable-print() {

  export DATAMART1=$1

  cat $DATAMART1| head -1 |           tr "^" "\n" > $DATAMART1.dheaders
  cat $DATAMART1| head -2 | tail -1 | tr "^" "\n" > $DATAMART1.dvalues1
  cat $DATAMART1| head -3 | tail -1 | tr "^" "\n" > $DATAMART1.dvalues2
  cat $DATAMART1| head -4 | tail -1 | tr "^" "\n" > $DATAMART1.dvalues3

  echo "##################################################### CONTENT OF $DATAMART and $DATAMART2"
  echo ""
  echo ""
  echo ""
  pr -S"|" -w 150 -m -t $DATAMART1.dheaders $DATAMART1.dvalues*
  echo ""
  echo ""
  echo ""
  echo "#####################################################"
  rm $DATAMART1.dheaders $DATAMART1.dvalues*

}

function qtables-print() {

  export DATAMART1=$1
  export DATAMART2=$2

  cat $DATAMART1| head -1 |           tr "^" "\n" > $DATAMART1.dheaders
  cat $DATAMART1| head -2 | tail -1 | tr "^" "\n" > $DATAMART1.dvalues1
  cat $DATAMART1| head -3 | tail -1 | tr "^" "\n" > $DATAMART1.dvalues2
  cat $DATAMART1| head -4 | tail -1 | tr "^" "\n" > $DATAMART1.dvalues3
  cat $DATAMART2| head -1 |           tr "^" "\n" > $DATAMART2.dheaders
  cat $DATAMART2| head -2 | tail -1 | tr "^" "\n" > $DATAMART2.dvalues1
  cat $DATAMART2| head -3 | tail -1 | tr "^" "\n" > $DATAMART2.dvalues2
  cat $DATAMART2| head -4 | tail -1 | tr "^" "\n" > $DATAMART2.dvalues3

  echo "##################################################### CONTENT OF $DATAMART and $DATAMART2"
  echo "SEPARATORS FOR HEADERS / VALUES: `cat $DATAMART1.dheaders | wc -l` / `cat $DATAMART1.dvalues1 | wc -l`"
  echo "SEPARATORS FOR HEADERS / VALUES: `cat $DATAMART2.dheaders | wc -l` / `cat $DATAMART2.dvalues1 | wc -l`"
  echo ""
  echo ""
  echo ""
  pr -S"|" -w 150 -m -t $DATAMART1.dheaders $DATAMART1.dvalues* $DATAMART2.dheaders $DATAMART2.dvalues*
  echo ""
  echo ""
  echo ""
  echo "#####################################################"
  diffuse $DATAMART1.dvalues1 $DATAMART2.dvalues1
  diffuse $DATAMART1.dvalues2 $DATAMART2.dvalues2
  diffuse $DATAMART1.dvalues3 $DATAMART2.dvalues3
  rm $DATAMART1.dheaders $DATAMART1.dvalues* $DATAMART2.dheaders $DATAMART2.dvalues*

}

# Create a table header string from a .sql script describing a table
function qtable-extract-header-from-sql() {
  SQL_FILE_PATH=$1
  cat $SQL_FILE_PATH | grep -i "string\|float\|timestamp\|integer\|double\|bigint\|boolean\|char\|decimal\|real\|smallint\|tinyint\|varchar" | awk '{print $1}' | tr "\n" "," | sed 's/.$//'
  echo ""
}

function qtable-open-with-header-sql() {
  SQL_SCRIPT="$1"
  TABLE_CONTENT="$2"
  OUTPUT="$TABLE_CONTENT".output.csv
  qtable-extract-header-from-sql "$SQL_SCRIPT" > /tmp/header.csv
  cat /tmp/header.csv > "$OUTPUT"
  cat "$TABLE_CONTENT" | sed 's/\^/,/g' >> "$OUTPUT"
  echo "$OUTPUT"
  gop "$OUTPUT"
}

function qtable-open() {
  cat "$1" | sed 's/\^/,/g' > "$1".csv
  echo "$1".csv
  gop "$1".csv
}

