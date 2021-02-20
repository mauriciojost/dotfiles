function qboursorama-analyse() {
  rm -f /tmp/bourso.csv /tmp/bourso.csv.tmp $HOME/Downloads/export*.csv
  echo "Remember to:"
  echo "- go to Evolution de mon solde "
  echo "- select the card you are interested in "
  echo "- select the time period you are interested in (remember that limits are inclusive, i.e. for a full month 2020-01-01 to 2020-01-31)"
  echo "- then click on Exporter au format csv (file must land in $HOME/Downloads/export...csv)"
  echo ""
  echo "Press ENTER once the file has been downloaded..."
  read -i xx
  local input="$(readlink -e $HOME/Downloads/export*.csv)"
  iconv -f ISO-8859-1 -t UTF-8 "$input" -o /tmp/bourso.csv.tmp
  cat /tmp/bourso.csv.tmp | sed -E 's/(.*)([0-9]) ([0-9])(.*)/\1\2\3\4/g' > /tmp/bourso.csv # values greater than 1k are represented wrongly (for instance 1300 would be represented as 1 300 by boursorama)

  screen -AdmS myshell -t balance bash -c "python2-q-text-as-data -b --output-header --skip-header --delimiter=';' 'select sum(amount) as balance, max(dateOp) as max_date, min(dateOp) as min_date from /tmp/bourso.csv' | fzf --no-sort"
  screen -S myshell -X screen -t summary bash -c "python2-q-text-as-data -b --output-header --skip-header --delimiter=';' 'select sum(amount), accountLabel, categoryParent from /tmp/bourso.csv group by accountLabel, categoryParent order by sum(amount)' | fzf --no-sort"
  screen -S myshell -X screen -t summary++ bash -c "python2-q-text-as-data -b --output-header --skip-header --delimiter=';' 'select sum(amount), accountLabel, categoryParent, category from /tmp/bourso.csv group by accountLabel, categoryParent, category order by sum(amount)' | fzf --no-sort"
  screen -S myshell -X screen -t details bash -c "python2-q-text-as-data -b --output-header --skip-header --delimiter=';' 'select (amount - 0.0) as amnt, dateOp as date, label, categoryParent as catPar, category as cat, supplierFound as supplier, accountLabel as account from /tmp/bourso.csv order by amnt' | fzf --no-sort"
  screen -x myshell
}
