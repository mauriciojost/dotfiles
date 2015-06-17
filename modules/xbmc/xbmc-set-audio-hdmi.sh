#!/bin/bash

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



echo "Re-setting audio settings..."

resetaudio 

echo "Done."

