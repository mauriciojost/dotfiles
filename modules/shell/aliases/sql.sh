function qsqlite3-fix-db() {
  local sqlite_file="$1"
  sqlite3 "$sqlite_file" .dump | grep "^ROLLBACK" -v > dump 
  echo "COMMIT;" >> dump
  sqlite3 "fix_$sqlite_file" < dump
  rm dump
}
