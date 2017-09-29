function qsbt-test-only(){
  CLASS_PATTERN=$1
  CLASS=`find | grep $CLASS_PATTERN | grep '\.scala' | sed 's/\.\/src\/test\/scala\///g' | sed 's/\//./g' | sed 's/.scala//' | head -1`
  echo "### Testing class $CLASS"
  sbt "testOnly $CLASS"
  echo "### Done"
}

function qsbt-class(){
  CLASS_PATTERN=$1
  find | grep $CLASS_PATTERN | grep '\.scala' | sed 's/\.\/src\/test\/scala\///g' | sed 's/\//./g' | sed 's/.scala//'
}

function qsbt-dependencies(){
  REPORT=`find target/resolution-cache/ | grep compile-internal.xml`
  echo "Found report at: $REPORT"
  REPORT_URL=file://`readlink -e $REPORT`
  echo "Opening $REPORT_URL (this may take a while)..."
  firefox $REPORT_URL
}

function qsbt-scoverage(){
  REPORT=$(find * -name index.html | grep scoverage-report)
  REPORT_FULL=$(readlink -e $REPORT)
  REPORT_URL=file://$(readlink -e $REPORT_FULL)
  echo 'Run after: sbt clean "set every coverageEnabled := true" test coverageReport && sbt coverageAggregate'
  echo "Opening $REPORT_URL (this may take a while)..."
  firefox $REPORT_URL
}

function qsbt-on-module-run-only-test(){
  MODULE=$1
  CLASS=$2
  sbt "project $MODULE" "test-only $CLASS"
}

