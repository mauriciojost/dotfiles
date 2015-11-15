#!/bin/bash

CURRDIR=$(dirname "$0")
CURRDIR=$(readlink -e "$CURRDIR")
TARGET=$HOME/.logs/followup.tsv
LOGSCRIPT=$CURRDIR/read-current-status.bash

mkdir -p $HOME/.logs/

if [ -f "$TARGET" ] 
then
  $LOGSCRIPT CONT &>> $TARGET
else 
  $LOGSCRIPT INIT &>> $TARGET
fi


