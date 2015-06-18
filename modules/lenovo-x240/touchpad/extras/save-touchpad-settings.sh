#!/bin/bash

CURRDIR="`dirname $0`"
source $CURRDIR/env.sh

xinput list-props $DEVICEID | grep "(" > $INPUT
