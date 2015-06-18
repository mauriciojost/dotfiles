#!/bin/bash

CURRDIR="`dirname $0`"
source $CURRDIR/env.sh

SCRIPT_EXECUTABLE=/tmp/touchpad-script-generated.sh

COMMAND="xinput set-prop $DEVICEID \1 \2"
REGEX='s/.*(\(.*\)):\(.*\)/'$COMMAND'/g'

echo "set -x" > $SCRIPT_EXECUTABLE
cat $INPUT | sed "$REGEX" | xargs -I% echo %  "; sleep 0.1" >> $SCRIPT_EXECUTABLE

chmod +x $SCRIPT_EXECUTABLE

$SCRIPT_EXECUTABLE

wall Done
