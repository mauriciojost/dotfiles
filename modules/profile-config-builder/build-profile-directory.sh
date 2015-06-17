#!/bin/bash

CURRDIR=`dirname $0`
CURRDIR=`readlink -e $CURRDIR`
INPUT=$CURRDIR/input
OUTPUT=$CURRDIR/output
export PATCHDIRS=$CURRDIR/configs
export PATCH_PATH_GENERIC=$PATCHDIRS/all
export PATCH_PATH_SPECIFIC=$PATCHDIRS/profile1

source $CURRDIR/functions.sh

copy_tree $INPUT $OUTPUT 
copy_tree $PATCH_PATH_GENERIC $OUTPUT 
copy_tree $PATCH_PATH_SPECIFIC $OUTPUT 

