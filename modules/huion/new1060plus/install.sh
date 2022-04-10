#!/usr/bin/env

set -e
set -u
set -x

# install driver
#wget https://github.com/DIGImend/digimend-kernel-drivers/releases/download/v10/digimend-dkms_10_all.deb
#sudo dpkg -i digimend-dkms_10_all.deb

# set configuration file
sudo ln -fs 50-huion.conf /usr/share/X11/xorg.conf.d/50-huion.conf

# sanity check, do you see the new device?
echo "Keep unplugged..."
read

xinput --list
dkms status
xsetwacom --list

echo "Now plug it (below the same commands should include the tablet)..."
read

xinput --list
dkms status
xsetwacom --list
