# Bluetooth

sudo apt-get install pulseaudio-module-bluetooth
pactl load-module module-bluetooth-discover
pactl list modules | grep blue

sudo /etc/init.d/bluetooth restart
pulseaudio -k
pulseaudio --start

If the device says something about stream failed just remove it from your list and add it again, then try again.

