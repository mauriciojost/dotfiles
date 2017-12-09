#!/bin/bash

#This minimalistic module helps doing batch conversion of files. 

#Is specially meant to be used to convert:

#- raw photographies into jpg
#- large volume videos into smaller videos

function qconvert-jpg() {
  echo "Ignore: $1"
}

function qconvert-avi() {
  avconv -i "$1" -c:v libx264 -c:a copy "$1.converted.mp4"
}

function qconvert-normalize-mp4() {
  local file=`readlink -e $1`
  $HOME/opt/avidemux --load "$file" --nogui --audio-codec AC3 --video-codec x264 --output-format MP4 --save "$file.converted.mp4" --quit
}

function qconvert-arw() {
  rawtherapee -j95 -o "$1.converted.jpg" -c "$1"
}

function qconvert-db() {
  echo "Ignore: $1"
}

function qconvert-X() {
  local f="$1"
  local ext="${f##*.}"
  echo "Has to convert file ${f,,} with extension ${ext,,}"
  convert-${ext,,} ${f}
}

function qconvert-all-in-X() {
  directory="$1"
  for f in `find $directory -type f`
  do
    fabs=`readlink -e $f`
    qconvert-X "$fabs"
  done
}
