
function qflamegraph-benchmark-pid-X-iters-Y-every-Z-secs() {
  local pid=$1
  local iterations=$2
  local period_secs=$3
  local fg=$DOTFILES/modules/flamegraph/

  temp_stacks=`mktemp`
  temp_acum=`mktemp`
  temp_index_html=`mktemp`.html
  i=0; while (( i++ < $iterations )); do jstack $pid >> $temp_stacks; sleep $period_secs; done
  cat $temp_stacks | $fg/stackcollapse-jstack.pl > $temp_acum
  $fg/flamegraph.pl $temp_acum > $temp_index_html
  echo "Report in: $temp_index_html"
}


