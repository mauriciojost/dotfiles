
# Execute an sql query as follows: qsql "select * from table.csv"
alias qsql="python2-q-text-as-data --output-delimiter='^' --output-header --skip-header --delimiter='^'"

alias qsqlc="python2-q-text-as-data --output-delimiter=',' --output-header --skip-header --delimiter=','"

alias qsqls="python2-q-text-as-data --output-delimiter=';' --output-header --skip-header --delimiter=';'"

function qsql-pretty(){
  python2-q-text-as-data --tab-delimited-output --output-header --skip-header --delimiter='^' "$1" | vd
}

