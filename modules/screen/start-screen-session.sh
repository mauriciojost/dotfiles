#!/bin/bash

SCREEN_NAME=mys
NL=`echo -ne '\015'`

function initialize_screen {
  screen -d -m -S "$SCREEN_NAME" -t "MAIN" -s /bin/bash
  screen -r "$SCREEN_NAME" -X setenv PROMPT_COMMAND /bin/true
}

function screen_process {
  local name=$1
  local command="$2"

  screen -S "$SCREEN_NAME" -X screen -t "$name"
  sleep 3
  screen -S "$SCREEN_NAME" -p "$name" -X stuff "$command" 
}

initialize_screen

screen_process "WINDOW1" "sleep 1 $NL" 
screen_process "WINDOW2" "sleep 2 $NL" 
screen_process "WINDOW3" "sleep 3 $NL" 
