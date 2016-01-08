#!/bin/bash
CURRDIR="`dirname $0`"
CONFIGDIR="/usr/share/X11/xorg.conf.d/"
sudo ln -sf `readlink -e $CURRDIR/$CONFIGDIR//50-synaptic.conf` $CONFIGDIR 
ls -lah $CONFIGDIR
cat $CONFIGDIR/50-synaptic.conf
