#!/bin/bash

CURRDIR="`dirname $0`"
source $CURRDIR/env.sh

COMMAND="\tOption \"\1\" \"\2\""
#REGEX='s/\(.*\)(.*):\(.*\)/'$COMMAND'/'
REGEX='s/.*(\(.*\)):\(.*\)/'$COMMAND'/g'

rm -f $CONFIG_BLOCK_FILE
cat $TEMPLATE | awk '/REPLACEHERE/{exit}1' > $CONFIG_BLOCK_FILE
cat $INPUT | grep -v Node | grep -v Product | sed "$REGEX" >> $CONFIG_BLOCK_FILE
cat $TEMPLATE | awk '/REPLACEHERE/,0' >> $CONFIG_BLOCK_FILE

echo "File at $CONFIG_BLOCK_FILE"
cat $CONFIG_BLOCK_FILE


