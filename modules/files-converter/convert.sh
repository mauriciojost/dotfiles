#!/bin/bash

set -x
set -e

function convert_jpg() {
  echo "Ignore: $1"
}

function convert_avi() {
  avconv -i "$1" -c:v libx264 -c:a copy "$1.converted.mp4"
}

function convert_arw() {
  rawtherapee -j95 -o "$1.converted.jpg" -c "$1"
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
