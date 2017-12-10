#!/bin/bash

# This minimalistic module helps doing batch conversion of files. 
# Is specially meant to be used to convert:
# - raw photographies into jpg
# - large volume videos into smaller videos

function qconvert-jpg() {
  echo "Ignore: $1"
}

function qconvert-avi() {
  avconv -i "$1" -c:v libx264 -c:a copy "$7.mp4"
}

function qconvert-mp4() {
  local file="$1"
  local directory="$2"
  local base="$3"
  #local name="$4"
  #local ext="$5"
  local logfile="$6"
  local baseconverted="$7"

  VIDEOBITRATE="cbr=512"
  AUDIOBITRATE="64"
  $HOME/opt/avidemux --load "$file" \
    --nogui --audio-codec AC3 --video-codec x264 \
    --video-conf $VIDEOBITRATE --audio-bitrate $AUDIOBITRATE \
    --output-format MP4 --force-alt-h264 \
    --save "$baseconverted.mp4" --quit &> $logfile
}

function qconvert-arw() {
  rawtherapee -j95 -o "$7.jpg" -c "$1"
}

function qconvert-orf() {
  rawtherapee -j95 -o "$7.jpg" -c "$1"
}

function qconvert-db() {
  echo "Ignore: $1"
}

function qconvert-X() {
  local file=$(readlink -e $1)
  local directory=$(dirname $file)
  local base=$(basename $1)
  local name="${base%.*}"
  local ext="${base##*.}"
  local logdir="$directory/logs"
  local logfile=$logdir/$base.converted.log
  local baseconverted="$file.converted"

  mkdir -p "$logdir"

  if [[ "$name" == *".converted"* ]]
  then
    echo "Skipping file ${file,,} with extension ${ext,,} (its a converted file)"
  elif compgen -G "$baseconverted.*" > /dev/null
  then
    echo "Skipping file ${file,,} with extension ${ext,,} (converted already exists)"
  else
    echo "- Converting file ${file}"
    echo "    with directory ${directory}"
    echo "    with base ${base}"
    echo "    with name ${name}"
    echo "    with extension ${ext,,}"
    echo "    with logfile ${logfile}"
    echo "    to                        ${baseconverted}.XXX"
    qconvert-${ext,,} ${file} ${directory} ${base} ${name} ${ext} ${logfile} ${baseconverted}
  fi
}

function qconvert-all-in-X() {
  local directory="$1"
  for f in $(find $directory -type f)
  do
    local file_abs=$(readlink -e $f)
    qconvert-X "$file_abs"
  done
}
