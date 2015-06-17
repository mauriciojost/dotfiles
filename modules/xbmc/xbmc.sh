#!/bin/bash

# This script starts a graphical application (like XBMC) and 
# moves its window to a TV screen in fullscreen mode.
# Application parameters 
APP_EXECUTABLE=xbmc
APP_EXECUTABLE_TO_KILL=xbmc.bin
APP_WINDOW_NAME="XBMC Media Center"

# Parameters of the TV screen
NAME_PC=LVDS1
PC_W=1600
PC_H=900
MODE_PC="$PC_W"x"$PC_H"
NAME_TV=HDMI1
TV_W=1920
TV_H=1080
MODE_TV="$TV_W"x"$TV_H"
DISPLAY_TO_USE=":0.0"

# New window parameters
G=0     # New gravity of the window
X=$PC_W # New X position of the window
Y=0     # New Y position of the window
W=$TV_W # New width of the window
H=$TV_H # New height of the window

# Parameters of the PC screen
BACKLIGHT_AFTER_APP=0

# Parameters of audio 
AUDIO_DEVICE=0 
AUDIO_PROFILE=output:hdmi-surround+input:analog-stereo
AUDIO_PROFILE_DEFAULT=input:analog-stereo

function resetaudio() {
  sleep 2
  pactl set-card-profile $AUDIO_DEVICE $AUDIO_PROFILE_DEFAULT
  sleep 2 
  pactl set-card-profile $AUDIO_DEVICE $AUDIO_PROFILE 

  sleep 2
  pactl set-card-profile $AUDIO_DEVICE $AUDIO_PROFILE_DEFAULT
  sleep 2 
  pactl set-card-profile $AUDIO_DEVICE $AUDIO_PROFILE 
}

export DISPLAY=$DISPLAY_TO_USE

echo "Checking that TV screen $NAME_TV is connected..."
OUTPUT=`xrandr | grep $NAME_TV | grep -v disconnected`
if [ -z "$OUTPUT" ]
then
  echo "TV seems to be not connected, aborting process..."
  while killall $APP_EXECUTABLE_TO_KILL 2>/dev/null; do sleep 0.5; done
  exit 0 
fi


if [ "$1" == "--restart" ]
then

  echo "Restarting all $APP_WINDOW_NAME..."

  echo "Killing all instances of $APP_EXECUTABLE..."
  while killall $APP_EXECUTABLE_TO_KILL 2>/dev/null; do sleep 0.5; done

  echo "Running $APP_EXECUTABLE..."
  $APP_EXECUTABLE $@ &

else

  echo "Keeping existing instances of $APP_WINDOW_NAME..."

  echo "Checking if there are indeed instances of $APP_WINDOW_NAME..."
  OUTPUT=`wmctrl -d -G -l | grep "$APP_WINDOW_NAME"`
  if [ -z "$OUTPUT" ]
  then
    echo "No instances of $APP_WINDOW_NAME found! Starting an instance..."
    $APP_EXECUTABLE $@ &
  else
    echo "Instances of $APP_WINDOW_NAME indeed found, all right."
  fi

fi

echo "Configuring TV for $APP_WINDOW_NAME..."
xrandr --output $NAME_PC --mode $MODE_PC --output $NAME_TV --mode $MODE_TV --right-of $NAME_PC


echo "Waiting for $APP_WINDOW_NAME window to come up..."
OUTPUT=""
while [ -z "$OUTPUT" ]
do
  sleep "0.1"
  OUTPUT=`wmctrl -d -G -l | grep "$APP_WINDOW_NAME"`
done

echo "Initial configuration of the window $APP_WINDOW_NAME :" 
echo $OUTPUT 

OUTPUT2=`echo $OUTPUT | grep "$APP_WINDOW_NAME" | grep "$H" | grep "$W" | grep "$X" | grep "$Y"`
if [ ! -z "$OUTPUT2" ]
then
  echo "$APP_WINDOW_NAME seems to be already correct. Leaving it."
  exit 0 
else 
  echo "$APP_WINDOW_NAME seems to be incorrect."
fi

echo "Proceeding to set up..."

wmctrl -r "$APP_WINDOW_NAME" -b remove,modal
wmctrl -r "$APP_WINDOW_NAME" -b remove,sticky
wmctrl -r "$APP_WINDOW_NAME" -b remove,maximized_vert
wmctrl -r "$APP_WINDOW_NAME" -b remove,maximized_horz
wmctrl -r "$APP_WINDOW_NAME" -b remove,shaded
wmctrl -r "$APP_WINDOW_NAME" -b remove,skip_taskbar
wmctrl -r "$APP_WINDOW_NAME" -b remove,skip_pager
wmctrl -r "$APP_WINDOW_NAME" -b remove,hidden
wmctrl -r "$APP_WINDOW_NAME" -b remove,fullscreen
wmctrl -r "$APP_WINDOW_NAME" -b remove,above
wmctrl -r "$APP_WINDOW_NAME" -b remove,below

echo "Setting position of the new window of $APP_WINDOW_NAME..." 
wmctrl -r "$APP_WINDOW_NAME" -e $G,$X,$Y,$W,$H 

echo "Adding fullscreen property to the window of $APP_WINDOW_NAME..." 
wmctrl -r "$APP_WINDOW_NAME" -b add,fullscreen 

echo "Current configuration of the window $APP_WINDOW_NAME:" 
wmctrl -d -G -l | grep "$APP_WINDOW_NAME"

echo "Re-setting audio settings..."

resetaudio 

echo "Configuring backlight of PC..."
xbacklight -set $BACKLIGHT_AFTER_APP

echo "Done."

