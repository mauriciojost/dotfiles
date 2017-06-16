#!/bin/bash

set -e
set -x

HOME_ROUTER_IP=10.0.0.1
LOG=/tmp/update-nas-mount.bash.log

ping -c 1 $HOME_ROUTER_IP -W 1

if [ "$?" == "0" ]
then
  echo "At home, mounting..." &>> $LOG
  mount /mnt/nas &>> $LOG
else
  echo "Not at home, unmounting..." &>> $LOG
  sudo umount -f -l /mnt/nas &>> $LOG
fi

