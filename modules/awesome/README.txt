### Awesome configuration

0. Set up some paths 

   $ export AWESOMEDIR=/etc/xdg/awesome/

1. Get and install vicious.
   $ git clone http://git.sysphere.org/vicious
   $ chmod -R a+X+r vicious
   $ sudo mv vicious /etc/xdg/awesome/

2. Put rc.lua's symbolic link in place

   $ sudo rm /etc/xdg/awesome/rc.lua
   $ sudo chmod a+r ./rc.lua
   $ sudo ln -s `readlink -e rc.lua` /etc/xdg/awesome/rc.lua

