function qloc-sum-column() {
  awk -v col="$1" '{ sum += $col } END{ print sum }'
}
function qloc-list-files() {
  find  \( -name '*.md' -o -name '*.scala' -o -name '*.sbt' -o -name Jenkinsfile -o -name '*.xml' -o -name '*.properties' -o -name '*.conf' -o -name '.repositories' -o -name '*.sql' \) | grep -v target | grep -v .idea
}

function qloc-list-files-no-test() {
  qloc-list-files | grep -v test
}

function qloc() {
  sbt clean
  proj=$(basename $(realpath .))
  fcount=$(qloc-list-files | wc -l)
  lines=$(for i in $(qloc-list-files); do wc -l $i; done | qloc-sum-column 1)
  size=$(for i in $(qloc-list-files); do ls -la $i; done | qloc-sum-column 5)
  fcountnt=$(qloc-list-files-no-test | wc -l)
  linesnt=$(for i in $(qloc-list-files-no-test); do wc -l $i; done | qloc-sum-column 1)
  sizent=$(for i in $(qloc-list-files-no-test); do ls -la $i; done | qloc-sum-column 5)

  echo "proj  fcount  fcountnt lines  linesnt size sizent"
  echo "$proj $fcount $fcountnt $lines $linesnt $size $sizent"
}


