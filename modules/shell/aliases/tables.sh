
# sudo apt-get install python3-q-text-as-data
# Execute an sql query as follows: qsql "select * from table.csv"
alias qsql="q --output-delimiter='^' --output-header --skip-header --delimiter='^'"

alias qsqlc="q --output-delimiter=',' --output-header --skip-header --delimiter=','"

alias qsqls="q --output-delimiter=';' --output-header --skip-header --delimiter=';'"

function qsql-pretty(){
  q --tab-delimited-output --output-header --skip-header --delimiter='^' "$1" | vd
}

alias qsql-explore="dbeaver"

