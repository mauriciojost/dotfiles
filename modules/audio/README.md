# README

From [this](https://askubuntu.com/questions/1038490/how-do-you-set-a-default-audio-output-device-in-ubuntu).


1. Identify the device that is default sink:

```
pactl list short sinks
pactl list short sinks | awk '{print $2}'
```

2. Identify the devide that is default source:

```
pactl list short sources
pactl list short sources | awk '{print $2}'
```

3. Edit the file /etc/pulse/default.pa with

```

# comment this:
# load-module module-switch-on-connect

# uncomment this so that:
### Make some devices default
set-default-sink bluez_sink.FC_F1_52_B3_B3_DB.a2dp_sink
set-default-source alsa_input.pci-0000_00_1f.3.analog-stereo
```

4. Reset pulseaudio with

```
mv ~/.config/pulse/ ~/.config/pulse2
pulseaudio -k
```

