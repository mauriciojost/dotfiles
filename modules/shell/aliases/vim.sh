function qmarkdown-sql-calculate() {

  # Example of use
  # Put in your markdown the following:
  # Anticipation (id=anticipate effort=5 gain=10)     <<< gets extracted and put into a queriable csv
  # CALCULATE: select id, effort, gain, gain / effort as value from table order by value   <<< query to perform

  # Open in VIM and execute MdCalculate

  local file="$1"
  local csv=a
  cat "$file" | egrep -o '([\(]id=\w+ (\w+=\w+[ \)])+)' > $csv
  local query=$(cat "$file" | egrep -o 'select .* from .*$')
  sed -i 's#(##g' $csv
  sed -i 's#)##g' $csv
  sed -i 's# #^#g' $csv 
  sed -i 's#=#^#g' $csv 
  header=""
  even="true"
  last_column=""
  
  for c in $(cat $csv | head -1 | tr '^' ' ')
  do
	if [ "$even" == "true" ]
	then
	  even="false"
	  last_column="$c"
	  header="$header label_$c"
	else
	  even="true"
	  header="$header $last_column"
	fi
  done
  header_formatted=$(echo $header | sed 's/ *$//g' | sed 's# #^#g')
  echo $header_formatted > $csv.tmp
  cat $csv >> $csv.tmp
  mv $csv.tmp table
  python2-q-text-as-data --tab-delimited-output --beautify --output-header --skip-header --delimiter='^' "$query"
}
