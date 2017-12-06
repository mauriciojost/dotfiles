#!/bin/bash

set -x
set -e

function convert_jpg() {
  echo "Ignore: $1"
}

function convert_arw() {
  rawtherapee -j95 -c "$1"
}

function convert_db() {
  echo "Ignore: $1"
}

function convert() {
  local f="$1"
  local ext="${f##*.}"
  echo "Has to convert file ${f,,} with extension ${ext,,}"
  convert_${ext,,} ${f}
}

directory="$1"
for f in `find $directory -type f`
do
  fabs=`readlink -e $f`
  convert "$fabs"
done
