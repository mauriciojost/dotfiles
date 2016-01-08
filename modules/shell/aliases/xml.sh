
function qxml-find-on-path-X-the-xpath-Y(){

  MTMP=`mktemp`
  TPATH="$1"
  XPATH="$2"

  for i in `ls $TPATH | grep xml`
  do
    cat "$TPATH/$i" | xmllint --format - | xmllint --xpath "$XPATH" - &> $MTMP

    ERRCODE=$?

    if [ "$ERRCODE" == "0" ]
    then
      echo "#####################################"
      echo "### FILE $TPATH/$i"
      echo "#####################################"
      echo ""
      cat $MTMP
      echo ""
      echo ""
    fi

  done

  rm $MTMP

}

function qxml-find-on-file-X-the-xpath-Y(){

  FILE="$1"  
  XPATH="$2"

  xmllint --format "$FILE" | xmllint --xpath "$XPATH" -
  echo ""
  echo ""

}
