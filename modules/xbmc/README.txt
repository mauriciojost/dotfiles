1. Make a link to /usr/bin of this script.

	sudo ln -s `readlink -e xbmc.sh` /usr/bin/xbmc.sh

2. Edit 

	sudo vim /usr/share/applications/xbmc.desktop

and replace all the xbmc by xbmc.sh so this script is used.

3. That's all folks :) 


