# Bluetooth

## Installation

Only once you should do in your Linux PC: 
- sudo apt-get install pulseaudio-module-bluetooth
- pactl load-module module-bluetooth-discover
- pactl list modules | grep blue

## Making it work

- sudo /etc/init.d/bluetooth restart
- pulseaudio -k
- pulseaudio --start

If the device says something about stream failed just remove it from your list and add it again, then try again.

- Go to the bluetooth icon in the tray bar, choose devices. 
- Clean all devices. No devices trusted.
- Turn on your device in discovery mode.
- Launch the search in the PC until you can successfully pair your headset (no password should be required, if so retry).
- Then trust the device.
- Then connect to the device using `headset` mode connection. 
- Use the Audio profile `High Fidelity ...` if quiality is not good enough.
