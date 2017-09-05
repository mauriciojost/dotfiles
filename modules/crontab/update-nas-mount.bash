#!/bin/bash

set -e
set -x

HOME_NAS_IP="$1"
LOG=/tmp/update-nas-mount.bash.log

echo "" >> $LOG
echo "" >> $LOG
date >> $LOG

ping -c 1 $HOME_NAS_IP -W 1 &>> $LOG

if [ "$?" == "0" ]
then
  echo "### At home, mounting..." &>> $LOG
  mount /mnt/nas &>> $LOG
else
  echo "### Not at home, unmounting..." &>> $LOG
  sudo umount -f -l /mnt/nas &>> $LOG
fi

echo "### Done." &>> $LOG
