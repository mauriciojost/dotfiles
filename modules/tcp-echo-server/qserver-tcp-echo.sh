#!/bin/bash

CURRDIR=`dirname $0`

PORT="$1"

if [ -z "$PORT" ]
then
	echo "Port not given."
	exit -1 
fi

python $CURRDIR/tcpecho.py $PORT
