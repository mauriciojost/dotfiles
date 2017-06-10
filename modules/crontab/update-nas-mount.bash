#!/bin/bash

set -e
set -x

HOME_ROUTER_IP=10.0.0.1

ping -c 1 HOME_ROUTER_IP -W 1

if [ "$?" == "0" ]
then
  echo "At home, mounting..."
  mount /mnt/nas
else
  echo "Not at home, unmounting..."
  sudo umount -f -l /mnt/nas
fi

