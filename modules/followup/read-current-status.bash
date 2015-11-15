#!/bin/bash

function getdate(){
  date +%s
}

function getbattery(){
  BATNUMBER=$1
  acpi | grep "Battery $BATNUMBER" | awk '{print $4}' | sed "s/,//g" | sed "s/%//g"
}

function getbacklight(){
  BACKL=`xbacklight -d :0.0`
  if [ "$?" = "0" ]
  then
    echo "$BACKL"
  else
    echo "-1"
  fi
}

function gettemperature(){
  acpi -t | awk '{print $4}'
}

DATE=`getdate`
BAT0=`getbattery 0`
BAT1=`getbattery 1`
BAKL=`getbacklight`
TEMP=`gettemperature`

if [ "$1" == "INIT" ]
then
  printf "TDATE\tIBAT0\tIBAT1\tDBAKL\tDTEMP\n"
else
  printf "$DATE\t$BAT0\t$BAT1\t$BAKL\t$TEMP\n"
fi



