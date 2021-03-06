# ROOT ACCESS

In some Linux distributions there is something known as Single User mode. In this mode, there is only one user, root. To access this mode, in grub, edit the entry that starts with 

```
kernel ... ro ….
adding 
kernel … ro … single 
```

That should lead you to a rooted console.

# FILESYSTEM & PERMISSIONS

```
nautilus
to see the full path rather than those horrible buttons press ctrl+L    (keywords 
to see not hidden files press ctrl+a
Regarding info from the system
cat /proc/cpuinfo         (number of cores running, features of the cores, etc. )
cat /proc/meminfo       (memory available in the system)
free                            (available physical memory in the system, -m expreses values in megabytes)
cat /etc/issue               (distribution name and version)
```

# TORRENT

```
deluge (deluge-console, deluge-gtk, deluge-web) client
has a daemon, to start it : $ deluged
port for web http://localhost:8112/
default password is : deluge

Using cut to get a specific field in a string
cut -d' ' -f 1

Rename batch files 
rename 's/^[0-9]*-//;' *

google java chrome plugin install
sudo ln -s /usr/lib/jvm/java-6-oracle/jre/lib/amd64/libnpjp2.so /opt/google/chrome/plugins/
```

# MOUNT SAMBA FILESYSTEM

```
sudo apt-get install cifs-utils

mjost@ciccio:/mnt/nas$ sudo cat /root/.smbcredentials
username=mjost
password=xxx
domain=yyy
mjost@ciccio:/mnt/nas$ sudo cat /etc/fstab
...
//10.0.0.12/home /mnt/nas/ cifs credentials=/root/.smbcredentials 0 0
mjost@ciccio:/mnt/nas$ 
```


# MOUNT ANDROID MTP FILESYSTEM (Ubuntu 12.04)

```
http://www.webupd8.org/2012/12/how-to-mount-android-40-ubuntu-go-mtpfs.html
sudo add-apt-repository ppa:webupd8team/unstable
sudo apt-get update
sudo apt-get install go-mtpfs
sudo apt-get install go-mtpfs-unity
go-mtpfs /tmp/mount
```

# REGARDING USERS

```
passwd username                                       change the password of username
su [userxx]                                           change the user to 'userxx'  (if no user specified, uses root)
sudo                                                  super user does
useradd -d HOMEDIR -m -s /bin/bash LOGINNAME          create a new user (to add password/ssh you do '# passwd LOGINNAME')
useradd -G {group-name} username                      create user and add it to group
vigr                                                  modify groups
chmod +x +r +w file_name                              change the attributes of a file for this user, eXecution, Readable, Writable
chmod 777 file_name                                   change the attributes of a file for all users
chmod ogua=xwr file_name                              o others, g group, u owner, a all mentioned before
chmod WHOWHAT FILE
chmod o-x-r-w file_name                               nothing for others
chmod og-x-r-w file_name                              nothing neither for others nor for the file's group
chown owner_name[:group_name] file_name               change the owner of this file, the only one who can change the permissions
killall -u username                                   kill all the processes (including the sshd) of this user
deluser --force username                              delete this user
finger                                                find out who's logged in 
gpg -c file.txt                                       encrypt file 
gpg file.txt.gpg                                      decrypt file
```
                                  

# REGARDING WEBDAV 

```
mount locally a webdav filesystem 
mount -t davfs https://novaforge.bull.com/alfresco-default/alfresco/webdav/sites/ /mnt/datascale
```

# MOUNT USING CREDENTIALS BUT PUTTING THEM OUTSIDE FSTAB

```
fstab like: curlftpfs#my-ftp-location.local /mnt/my_ftp fuse allow_other,uid=1000,gid=1000,umask=0022 0 0
/root/.netrc with 600 and: 
machine my-ftp-location.local
login ftp-user
password ftp-pass

https://linuxconfig.org/mount-remote-ftp-directory-host-locally-into-linux-filesystem

```
# REGARDING FILES SEARCH (FIND)

```
updatedb && locate file_name
or
grep "what to find" file_name
find / -name "name*" | xargs grep "something inside the file"
find -wholename "*/smth/name*" | xargs grep "something inside the file"
```

# REGARDING DISK/FILESYSTEM

```
df -h                                                     view a report of disk space usage per device 
tree                                                     make a tree of the filesystem
du -sh *                                                to see a list of files in the current directory and the disk space that they take
duv                                                      same as above (but better)
```

# SYNCHRONIZING FILES (RSYNC COMMAND)

```
a archive
v verbose
z compress 
r recursive
--checksum does not check files equality using date and size, use only checksum (MD5SUM)
--delete delete files in the destination that are not in the source
--exclude exclude files from being syncd
rsync   -vr --exclude “.git”  --delete   /path/to/source   destuser@desthost:/path/to/destination 

```

Useful example:

```
rsync -avzrP --inplace --delete --exclude ".git/" --exclude ".logs/" --exclude "RM_DB" --exclude "SCHEDULER_DB" --exclude "TEST_SCHEDULER_DB" $CURRDIR/scheduling mjost@vizcacha:~/
echo "Done."

```

# FILE SUDOERS 

To grant permissions to certain user to run `pm-suspend` create a new file `/etc/sudoers.d/99-custom.conf` with this content:
```
mjost   ALL=(ALL)       NOPASSWD:       /usr/sbin/pm-suspend
```

That's it!

## The old style

```
Give permissions to one user/group you must use:
1. su visudo -q     (it is vim specially created for /etc/sudoers file, to edit it with much caution)
2. Look for something like 
## Allow root to run any commands anywhere
root    ALL=(ALL)       ALL
## Allow cperMaster user to run on ALL hosts, command docker
cperMaster ALL= NOPASSWD: /usr/bin/docker

3. Add after that (pay attention, the white spaces are actually TABS)
planete ALL=(ALL)       ALL
4. Done!
## Allow mjost to run pm-suspend without password
mjost ALL=(ALL) NOPASSWD: /usr/sbin/pm-suspend

```


The sudoers file is a file that allows non-root users execute root commands. 
Here you have an example to allow user1 to run tcpdump.

```
# /etc/sudoers
#
# This file MUST be edited with the 'visudo' command as root.
#
# See the man page for details on how to write a sudoers file.
#
Defaults        env_reset
# Host alias specification
# User alias specification
User_Alias<tab>USERTCPDUMP = user1
# Cmnd alias specification
Cmnd_Alias<tab>TCPDUMP = /usr/sbin/tcpdump
# User privilege specification
root    ALL=(ALL) ALL
USERTCPDUMP<tab>ALL = TCPDUMP
# Allow members of group sudo to execute any command
# (Note that later entries override this, so you might need to move
# it further down)
%sudo ALL=(ALL) ALL
#
#includedir /etc/sudoers.d

```

# REGARDING PACKAGING AND COMPRESSION (TAR GZ)

keywords compress or decompress files comprimir descomprimir

```
j is for bz2
z is for bz
f for file (after any f there must be a file name .tar.x)
c is create
t is to list
tar -xf file.tar.bz2 (extracts the content of this file here)
tar -cf archive.tar directory1 directory2  (create file from these directories)
tar -cjf file.tar.bz2 (-C) directory/   (create compressed file from a directory)
tar -tvf file.tar (list all files inside this file)
zcat file.tar.gz (cats all the things from this compressed file)
```

# REGARDING MODULES

```
modprobe -r pcspkr           decouples a module (pcspkr) from the kernel
modprobe    pcspkr           connects a module (pcspkr) to the kernel
modinfo       pcspkr
lsmod                              list of modules running (already connected to the kernel)
find /lib/modules/$(uname -r) -name *.ko     list all the modules available to load in the system (you will see here the famous pcspkr)
lspci -v                             list of hardware devices and detailed information about them (including which "kernel driver"/module is being used for it)

```
# DISABLE GUI MODE 

keywords disable enable gui console text ubuntu boot screen startup login splash 

```
   $ sudo vim /etc/default/grub
From:
   GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
To:
   GRUB_CMDLINE_LINUX_DEFAULT="text"
Now you must update the grub configs:
   $ sudo update-grub
Done! After reboot, to start the gui just login and type:
   startx

```

# DNS

```
sudo vi /etc/resolv.conf and add
nameserver <ip>
DNS locally 
The following file controls which names are mapped to which IP addresses without asking to the default DNS server. 
/etc/hosts

127.0.0.1       localhost
IP<tab>name

Bypass firewall
If you have SSH access to one host, then you can have full access to any of its local firewall-blocked ports. 
First update /etc/hosts so that the remote host is mapped to the local host: 
127.0.0.1       remotehost
It means that any outgoing request will be mapped locally. 

Now set up tunnels, so that localhost:port maps to remotehost:port. 

localhost$ ssh -fN -L<localport>:<targethost>:<targetremoteport> <remotehost> -l login
localhost$ ssh -fN -L<localport>:<targethost>:<targetremoteport> <intermediatehost>

Connect to host and open port to get connection back
localhost$ ssh -v -R7777:localhost:22 <remotehost>

```
# OPEN PORTS (PORT SCANNING) 

```
keywords find out open ports port open firewall service 
netstat -ant                check locally which are the open ports (focused on ports)
lsof -i                         do a mapping between open ports and processes listening to them (focused on processes)
telnet localhost 22     check if locally there is a process listening to 22 (ssh)
nmap -P0 target        check from outside which TCP ports are open in target
nmap -sP 192.168.0.*  list all the ports 
nmap -sn 10.10.10.0/24 list or discover all available ip addresses in the current lan

```

States of the ports:

1. open
An application is actively accepting TCP connections, UDP datagrams or SCTP associations on this port. Finding these is often the primary goal of port scanning. Security-minded people know that each open port is an avenue for attack. Attackers and pen-testers want to exploit the open ports, while administrators try to close or protect them with firewalls without thwarting legitimate users. Open ports are also interesting for non-security scans because they show services available for use on the network.
2. closed
A closed port is accessible (it receives and responds to Nmap probe packets), but there is no application listening on it. They can be helpful in showing that a host is up on an IP address (host discovery, or ping scanning), and as part of OS detection. Because closed ports are reachable, it may be worth scanning later in case some open up. Administrators may want to consider blocking such ports with a firewall. Then they would appear in the filtered state, discussed next.
3. filtered
Nmap cannot determine whether the port is open because packet filtering prevents its probes from reaching the port. The filtering could be from a dedicated firewall device, router rules, or host-based firewall software. These ports frustrate attackers because they provide so little information. Sometimes they respond with ICMP error messages such as type 3 code 13 (destination unreachable: communication administratively prohibited), but filters that simply drop probes without responding are far more common. This forces Nmap to retry several times just in case the probe was dropped due to network congestion rather than filtering. This slows down the scan dramatically.
4. unfiltered
The unfiltered state means that a port is accessible, but Nmap is unable to determine whether it is open or closed. Only the ACK scan, which is used to map firewall rulesets, classifies ports into this state. Scanning unfiltered ports with other scan types such as Window scan, SYN scan, or FIN scan, may help resolve whether the port is open.
5. open|filtered
Nmap places ports in this state when it is unable to determine whether a port is open or filtered. This occurs for scan types in which open ports give no response. The lack of response could also mean that a packet filter dropped the probe or any response it elicited. So Nmap does not know for sure whether the port is open or being filtered. The UDP, IP protocol, FIN, NULL, and Xmas scans classify ports this way.
6. closed|filtered
This state is used when Nmap is unable to determine whether a port is closed or filtered. It is only used for the IP ID idle scan.


# Services

```
sudo service <servicename> start
sudo service <servicename> stop
sudo service <servicename> restart           # restart service

```
Boot of services (boot, start, services, bootup)
```
sudo updte-rc.d <servicename> defaults      # install for boot
sudo update-rc.d -f <servicename> remove     # remove from boot
sudo update-rc.d <servicename> disable       # disable boot
sudo update-rc.d <servicename> enable        # enable at boot

```

Create put this content in file /etc/init.d/foo 

```
#!/bin/bash

WORK_DIR="/var/lib/foo"
DAEMON="/usr/bin/python"
ARGS="/opt/foo/linux_service.py"
PIDFILE="/var/run/foo.pid"
USER="foo"

start() {
	echo "Starting server"
	mkdir -p "$WORK_DIR"
	/sbin/start-stop-daemon --start --pidfile $PIDFILE --user $USER --group $USER -b --make-pidfile --chuid $USER --exec $DAEMON $ARGS
}

stop() {

	echo "Stopping server"
	/sbin/start-stop-daemon --stop --pidfile $PIDFILE --verbose
}

status() {

	echo "Stopping server"
	/sbin/start-stop-daemon --stop --pidfile $PIDFILE --verbose
}

case "$1" in
  start)
	start
	;;
  stop)
	stop
	;;
  status)
	status
	;;
  restart)
	stop
	start
	;;
  *)
    echo "Usage: /etc/init.d/$USER {start|stop}"
    exit 1
    ;;
esac

exit 0

```

Then execute the above described steps to manipulate it. 


# REGARDING NETWORKING

```
ifup wlan0                      put up wifi interface
ifconfig eth0 up              put really up wired interface
ifdown eth0                    put down ethernet interface
ifconfig wlan0 up             put really up the wifi interface 
wpa_action wlan0 down   put down wlan0 interface, using wpa-roam package (more complete for wifi connections)
wpa_action wlan0 up
wpa_cli status
dhclient wlan0                 starts the dhcp handshake 
ifconfig interface_name up (turns on the given interface)
ifconfig interface_name down (turns off the given interface)
dhclient interface_name (makes the given interface work with DHCP)
important packages to install: ifupdown spasupplicant wireless_tools
service stop network-manager      to avoid interference with ours, ifup and ifdown (from package ifupdown)
service start network-manager      if we want the default network manager to work
/etc/init.d/network-manager stop
iwlist scan                      scan wifi networks
once the right network is found, we will use (so install them both with aptitude) ifupdown and wpasupplicant packages.

```
Normal procedure to get wifi working: 
```
sudo wpa_supplicant -iwlan0 -c./mydocs/linux/config/wpa-roam.conf -d
and paralelly...
sudo dhclient wlan0
```
where in wpa-roam.conf we added (to examples)  

```
..........................
network={
ssid="anastasias_essid"
psk="thisismynetworkpassword"
id_str="home_id_name"
}

network={
        ssid="eduroam"
        scan_ssid=1
        key_mgmt=WPA-EAP
        eap=TTLS
        anonymous_identity="anonymous@inria.fr"
        identity="mjost"
        password="passwordhere"
        phase2="auth=PAP"
}
..........................

```
And, to the /etc/network/interfaces add the following:

```
..........................
allow-hotplug wlan0
iface wlan0 inet manual
       wpa-roam /etc/wpa_supplicant/wpa-roam.conf
..........................

```
Make a script run on ubuntu at boot time
To make the script run with the start argument at the end of the start sequence, and run with the stop argument at the beginning of the shutdown sequence:

```
#Example of /etc/init.d/myscript
#!/bin/bash
case "$1" in
  start)
    nohup sleep 1777 &> /tmp/myscript.log &
    ;;
  stop)
    pkill sleep
    ;;
  *)
  ;;
esac
        
sudo chmod +x /etc/init.d/myscript
sudo update-rc.d myscript defaults 98 02

```

# Video encoding crop split tool mencoder

```
   $ mencoder $INPUT -ovc x264 -vf crop=$largopx:$anchopx:x:y -frames $amount_of_frames_to_read -o output.mp4
example
   $ mencoder input.mp4 -ovc x264 -vf crop=960:1080:1920:0 -frames 10000 $OPTS -o output.mp4
```

# tcpdump-like programs

```
local interface range of ports, and show them in hexadecimal format
tcpdump -i eth0 portrange 8080-8090 -A -e | tee result
ngrep -W byline dst port 443 | tee result
ngrep -W normal -d eth0 .../.+/devices/dev1./reports port 8090
```

# PROGRAMMING C

```
Regarding dependences
nm (list of symbols)
ldd (list dependences resolved and unresolved)
gdbtui executable_file PID          (attach the debugger to a given process)

```
# GENERAL

```
Finding manuals 
Find help
man -K keyword1 keyword2 keyword3                     find manuals containing those keywords
man2 xxx                
Regarding processes
top command
Just use:
$ top 
$ top -c                                                                           -c to see also the process command-line arguments
then to see other parameters press f and up/down with space to choose what process properties to show.
Others
ps -ef | grep given_process | grep -v grep                 see processes by greping the command line that was used to execute them
ps -ef                                                                   see the processes running in the system
kill -9 pid                                                              kills abruptly using the Process ID
killall process_name                                             kill the process by using its name
[re]nice [priority] pid                                              changes the priority of a process by using its process ID (priorities can be literally +19 +10 , -20, being -20 maximum and +19 minimum)
netstat -ntulp                                                        see which processes are listening to which port
lsof pid                                                                 list of files opened by this process

```
# Re-installing packages
```
keywords install packages package software reinstall install backup re-install safe copy list 
  To make a local copy of the package selection states:
            dpkg --get-selections >myselections
       You might transfer this file to another computer, and install it there with:
            dpkg --clear-selections
            dpkg --set-selections <myselections


dpkg --get-selections > packages-base 
sudo dpkg --set-selections < packages-base 
sudo dselect update 
sudo apt-get dselect-upgrade
General ones
cat file.txt | head -5                                show the first part of a file
cat file.txt | tail -5                                   show the last part of a file
hexdump -C file.bin                                dump the file in ascii code and hexa code
tail -f filename                                        keeps checking for the file to change and shows an up to date screenshot of it
alsamixer                                              console mixer (to control the volume of each channel)
ps -ef | grep process_name | grep -v grep | awk '{print $2}' | xargs renice +19
*date --set="2 OCT 2006 18:00:00"            changes the time or date of the system by console
*date +"%d-%m-%y"                                print the current date with the given format  m month H hours  M minutes S seconds B month name
$RANDOM                                             to generate a random number
wall message                                         notify through console / terminal users about something you are doing, is a broadcast
alias rrr='ls -lah'                                      creates an alias to replace a command
unalias rrr                                              removes the alias rrr
alias                                                     shows the current alias
poweroff                                                shutdown the computer
xrandr --output LVDS-1 --brightness 1.5    change the LCD back-light brightness (from 0 to 7)
/usr/sbin/pm-hibernate                           hibernate the computer
/usr/sbin/pm-suspend                            suspend the computer
strace ‘command’ 2>&1 | grep open     see what files were opened by this command

Set the date properly 
sudo ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
sudo ntpdate pool.ntp.org

```
# Regarding mails
```
keywords send email e-mail mail attachment attached file console linux bash 
apt-get install xmail 
mail -a filetoattach.txt -s subject address@domain.com < /dev/null
mail -s SUBJECT DESTINATION -- -f SOURCE < /dev/null
mutt -a file.to.attach -s "subject of message" recipient@domain.com
Logs of mails in: /var/log/maillog


uuencode surfing.jpeg surfing.jpeg | mail sylvia@home.com

```
# Shortcuts
```
In general are the same as any browser (like Firefox or Chrome) but you press also Alt:
Minimize Alt + F9
Resize Alt + F8
Move Alt + F7
Maximize Alt + F10

Pero no anda en muchas máquinas (a pesar de configurarlo) sin ninguna estúpida razón...

http://www.palomatica.info/juckar/linux/resumen/comandos.html

```

# Regarding putting processes in background
```
Ctrl-Z pauses the current process in the console
fg puts back the process in foreground
bg puts the process in background mode

```

# Regarding console-based web browsers
```
links
links2
lynx
Linux web browser console Lynx bash text mode 
To install and use lynx (yum install lynx or:)
1. go to Downloads directory (with console)
2. wget http://lynx.isc.org/lynx2.8.7/lynx2.8.7.tar.gz
3. tar -xvf lynx2.8.7.tar.gz
4. cd lynx2-8-7
5. ./configure
6. make
7. ./lynx -cfg=./lynx.cfg -lss=./samples/lynx.lss http://whatismyipaddress.com/ip-lookup
where http... you put the webpage you need

```
# Linux sources (this case for Debian)
```
All linux sources are told in /etc/apt/sources.list
format:
[deb | deb-src ] [options] [repo uri] distribution [component1] [component2] [...] 
deb http://ftp.fr.debian.ord/debian/  sid   main non-free contrib

deb means binaries, while deb-src means sources 
options we don't use them here
distribution is either stable, testing,  or unstable (or they codenames, squeeze for Debian 6.0, wheezy for testing code being tested now to become the next stable version, and sid for unstable, respectively)

Interesting packages
noip        to update automatically one dns server according to the public ip that certain computer has
openssh-server      server ssh
iptables-persistent
            do what you need to to with your iptables and then execute     iptables-save >/etc/iptables/rules
```

# Regarding gnome-session
If any problem regarding the graphical interface take a look at the file ~/.xsession-errors

# Regarding gnome GUI
To get it, you only install the packages gnome-core (and maybe gnome-desktop-environment) and then try to go to tty7 to see if it works. 

# Regarding bluetooth
http://wiki.openmoko.org/wiki/Manually_using_Bluetooth
00:0B:E4:5E:DB:6D




# Regarding export (why is it important?)

```
$ ./script.sh 
ALALA is                    #ALALA undefined
$ ALALA=aa
$ ./script.sh                #ALALA defined but not exported to sub-processes
ALALA is
$ export ALALA=aa    
$ ./script.sh               #ALALA defined and exported to sub-processes
ALALA is aa     
```
 

# Regarding spoofing on linux (keywords spoof mac address change)
```
ifconfig eth0 down
ifconfig eth0 hw ether 00:11:22:33:44:55
ifconfig eth0 up

```
# Howto free memory in linux

```
sync
echo 1 > /proc/sys/vm/drop_caches
echo 2 > /proc/sys/vm/drop_caches
echo 3 > /proc/sys/vm/drop_caches

```
# Regarding bash history

```
Save history of bash as soon as you type (do not wait until the console closes to do it)
Put in .bashrc the following: 

```
# CHROOT
```
keywords jail environment safe test switch 
http://wiki.debian.org/Debootstrap
1. To first create the filesystem to later chroot, do: 
# debootstrap stable ./directory http://ftp.us.debian.org/debian
2. Then chroot. 
# chroot ./directory


```

# Restore GRUB after Windows installation

```
Boot using LiveCD, start terminal, and to find out the partition of the linux installation you want in GRUB:

$ sudo fdisk -l

then do 

sudo mount /dev/sdex /mnt
sudo ls /mnt/boot
you should see that boot directory contains boot information like a file like vmlinuz-2.6.35-30-generic

sudo for i in /dev /dev/pts /proc /sys; do sudo mount -B $i /mnt$i; done 
sudo chroot /mnt 
sudo update-grub

the last command should give a list of identified Operating Systems, including the Windows instance.

You need to reinstall GRUB in the MBR of the disk (not talking about the partition anymore)
sudo grub-install /dev/sda

If all right, restart the host and see. 


distribution too old that does not find repository servers 
sudo apt-get install aptitude sources list
just update 
/etc/apt/sources.list with new lines like (look in the internet what are the sources for your distribution, in this case quantal or ubuntu 12.10): 
deb http://old-releases.ubuntu.com/ubuntu/ quantal main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu/ quantal-security main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu/ quantal-updates main restricted universe multiverse


```

# LINUX FILESYSTEM TREE


```
Directory	Content
/bin	Common programs, shared by the system, the system administrator and the users.
/boot	The startup files and the kernel, vmlinuz. In some recent distributions also grub data. Grub is the GRand Unified Boot loader and is an attempt to get rid of the many different boot-loaders we know today.
/dev	Contains references to all the CPU peripheral hardware, which are represented as files with special properties.
/etc	Most important system configuration files are in /etc, this directory contains data similar to those in the Control Panel in Windows
/home	Home directories of the common users.
/lib	Library files, includes files for all kinds of programs needed by the system and the users.
/lost+found	Every partition has a lost+found in its upper directory. Files that were saved during failures are here.
/mnt	Standard mount point for external file systems, e.g. a CD-ROM or a digital camera.
/opt	Typically contains extra and third party software. All applications that lie in one folder (all docs+binaries+libraries in the same directory) will be put in /opt/app-name/
/proc	A virtual file system containing information about system resources. More information about the meaning of the files in proc is obtained by entering the command man proc in a terminal window. The file proc.txt discusses the virtual file system in detail.
/root	The administrative user's home directory. Mind the difference between /, the root directory and /root, the home directory of the root user.
/sbin	Programs for use by the system and the system administrator.
/tmp	Temporary space for use by the system, cleaned upon reboot, so don't use this for saving any work!
/usr	Programs, libraries, documentation etc. for all user-related programs.
/usr/X11R6/   
/usr/bin/       Where the binaries of the installed packages might be.
/usr/include/   Where the .h files of the installed packages might be.
/usr/lib/           Where the .so files of the installed packages might be.
/usr/lib/pkgconfig/  Where the information about each instalation might be (in form of .pc files)
/usr/libexec/
/usr/local/     Where it's recommended to install most of the programs. It has the same structure than /usr directory.
/usr/sbin/    
/usr/share/
/var	Storage for all variable files and temporary files created by users, such as log files, the mail queue, the print spooler area, space for temporary storage of files downloaded from the Internet, or to keep an image of a CD before burning it.


```
# Learning SSH
Install SSH server
Debian
```
  # aptitude install openssh-server
```
Configure SSH server

1. Start SSH daemon/server
```
  # /etc/init.d/sshd start
  # /etc/init.d/sshd stop
  # /etc/init.d/sshd start

```
2. Try 'ssh localhost'. If it works continue.

3. Then open port 22 ( SSH ) with iptables:
```
  # iptables -I INPUT -p TCP --dport 22 -j ACCEPT
```

Persistent iptables
```
# apt-get install iptables-persistent                // Install the service
# update-rc.d iptables-persistent defaults     // Connect it to the startup hook
# iptables -I INPUT -p TCP --dport 22 -j ACCEPT
# iptables-save > /etc/iptables/rules            // save as persistent the current rules

```
Create pair public and private keys
```
  # ssh-keygen -t rsa
```
Authentication for SSH (pair public/private keys)
1. In the client do:
 a. Create the pair public / private keys (create generate pair public private key public key private key)
```
  # ssh-keygen -t rsa
```
 After it is done you have
```
 $ ls ~/.ssh/
    id_rsa
    id_rsa.pub
```
 b. Make sure you change the permissions of .ssh and its content
```
   $ chmod -R 700 ~/.ssh/
```

2. In the server do (and troubleshooting):
 a. Append there the content of the client's file  ~/.ssh/id_rsa.pub in the authorized_keys file in the directory ~/.ssh/
    So,
```
           # vim ~./ssh/authorized_keys      and append
```
 DO NOT APPEND BY HAND, IT BRINGS PROBLEMS. Better use ssh-copy-id from the client
 b. Then change the permissions of .ssh and its content
```
  $ chmod -R 700 ~/.ssh/
  $ cd /home && chmod -R 700 userfolder
```
  To protect it, as usual.

It should be like this:
```
from ~/../       : drwx------ 2 user   user   4.0K May 22 11:16 user
from ~           : drwx------ 2 user   user   4.0K May 22 11:16 .ssh
from ~/.ssh   : -rw------- 1 user user  381 May 22 11:08 authorized_keys
from ~/.ssh   : -rwx------ 1 user user  884 May 22 10:54 known_hosts
```
 c. Set the configuration files to accept RSA Authentication.

Edit /etc/ssh/sshd_config and make sure you have the following lines.
```
RSAAuthentication yes
PubkeyAuthentication yes
```
d. Enable or disable password authentication

```
# TO DISABLE the standard username/password authentication method:
ChallengeResponseAuthentication no       
PasswordAuthentication no
UsePAM no         
```
```
# TO ENABLE the standard username/password authentication method:
ChallengeResponseAuthentication yes
PasswordAuthentication yes
UsePAM yes
```

 d. Then restart the SSH server (one of the two commands below):
```
   # /etc/init.d/sshd restart
   # service ssh restart
```

 e. Then try from the client to connect:
```
   ssh -i ~/.ssh/id_rsa user@host
```
 
Where user is the owner of the file ~/.ssh/authorized_keys in the server (find out with 'ls -lah ~/.ssh').
 It should work.

Remember, to use a private key with a server that has your public key, make sure your key is in ~/.ssh/id_rsa and that all the files in ~/.ssh/* have permissions 700 (all for owner, nothing for file group nor others different than them).

Regarding users that are not loggable through ssh
- Check the file
/etc/shadow (where passwords are) and check that in the second row (divided by : character) there is no        !!    written
- Make sure permissions of the .ssh folder and files inside is correct
Get public key from a private key
```
ssh-keygen -y -f ~/.ssh/id_rsa
```

# Ssh-agent
If you use a phassphrase to encript your private key (a must do) then you would be asked for this pass everytime you use the key. However ssh-agent alleviates this work, keeping the pass in memory and giving it everytime it’s asked. 
How to use it? Easy: 

```
   ssh-agent bash                                # start ssh-agent environment
   ssh-add ~/.ssh/new_id_rsa          # add key (pass will be asked once)

   ssh my_host                                     # no pass will be asked here
```

# Checking errors (log files)
```
# vim /etc/ssh/sshd_config
                                       LogLevel VERBOSE

#/etc/init.d/sshd restart
or
#/etc/init.d/ssh restart              (debian)

#tail -f /var/log/secure          (red hat)
or
#tail -f /var/log/auth              (debian)


cat /var/log/auth /var/log/secure /var/log/messages /var/log/syslog
```

Eventually there might be something in /var/log/messages and/or /var/log/syslog too.


# Examples of use (more complete ones)
scp user@10.10.44.55:/home/user/some_file.tar.gz ./
ssh user@10.10.44.55

ERROR or TROUBLESHOOTING : If you can’t access a server even though the private key you are using is correct + the server is correct (you can access it from other client) then the problem might be a .pub file in the client side, that does not match the used private key. Erase all the .pub files in the .ssh (in the client) and try again ;)

SSH client: putty

Create paired public/private keys (create generate public private
Authentication using private keys
Give to putty (or the ssh client) the private key:
Connections->SSH->Auth->Private key file for authentication, with all the options by default.
How does the Private key file look like?
- Linux -> private keys have no extension
- Windows -> file.ppk

(to transform a linux pk to a windows format use puttygen: click on LOAD and find the no extension private key file, then SAVE the private key being sure it is a .ppk file).

node0.cloud.sophia.inria.fr -> mjost



# SCREEN command
```
Keep a session alive even when you close the ssh connection

Normal workflow:  
$ screen -S SES           # to create a new session named “SES”
ctrl+a d                          # to dettach from this session

$ screen -S SES -r        # re-attach to the session named “SES”
$ screen -list                  # list current sessions
$ screen -r -x -S other   # re-attach to a non-detached session (multi display mode)

```

Another more primitive wat to do it is by 'nohup' (is like the operand &, but closing the ssh connection does not kill the process). If that doesn't work, try 'setsid'.

screen commands
```
ctrl-a ctrl-w          list windows
ctrl-a ctrl-n          switch to next window
ctrl-a ctrl-c          create new window
ctrl-a ctrl-w          list windows
ctrl-a X               switch to window X
ctrl-a ?               shows help
ctrl-a A               set window name (ctrl-a then release, and shitf+a)

ctrl-a ESC          useful to scroll down and up (screen enters into copy mode)

Store buffer into a file -> "CTRL+A :" + type "hardcopy -h <filename>"


```





Configuration

Put this all in  ~/.screenrc

```
# An alternative hardstatus to display a bar at the bottom listing the
# windownames and highlighting the current windowname in blue. (This is only
# enabled if there is no hardstatus setting for your terminal)
hardstatus on
hardstatus alwayslastline
hardstatus string "%{.bW}%-w%{.rW}%n %t%{-}%+w %=%{..G} %H %{..Y}%M %d %c"

# terminfo and termcap for nice 256 color terminal
# allow bold colors - necessary for some reason
attrcolor b ".I"
# tell screen how to set colors. AB = background, AF=foreground
termcapinfo xterm 'Co#256:AB=\E[48;5;%dm:AF=\E[38;5;%dm'
# erase background with current bg color
defbce "on"
# set TERM
# term screen-256color-bce
term xterm-256color

# kill startup message
startup_message off
# define a bigger scrollback, default is 100 lines
defscrollback 65536
# default shell title
shelltitle ""

# An example of a "screen scraper" which will launch urlview on the current
# screen window
#
bind ^B eval "hardcopy_append off" "hardcopy -h $HOME/.screen-urlview" "screen urlview $HOME/.screen-urlview"

# To get screen to add lines to xterm's scrollback buffer, uncomment the
# following termcapinfo line which tells xterm to use the normal screen buffer
# (which has scrollback), not the alternate screen buffer.
#
termcapinfo *xterm*|xterms|xs|rxvt ti@:te@



# wall command
Notify other users with the same login name, about something you are doing

$ wall message
```

# SSH Tunneling
keywords tunnel tunnels ssh bypass firewall
```
ssh -fN -L<localport>:<finalhost>:<finalport> <intermediatehost>
ssh -fN -L3389:node5.cloud.sophia.inria.fr:3389 node0.cloud.sophia.inria.fr (forwards: localhost:3389 >>> SSH in node0.cloud.sophia.inria.fr >>> node5.cloud.sophia.inria.fr:3389)
ssh -fN -L3000:localhost:3000 user@remotehost    (in remote host, “localhost”=remotehost so this will map local 3000 with the remote 3000)

the -fN is to run in background, and allow ssh to run without any specific command given to the server node0
so doing 'rdesktop localhost' (that uses port 3389 of destination) you will actually get connected to node5 (going through node0)
Easier tunneling
Use case: you want to use localhost:9555 to refer to remotehost:80 and see its http service from your browser.
This feature of sshd allows you to see remote hosts (only accessible through SSH) as hosts connected to your local network in the sense that their ports are open to you.

http://backdrift.org/transparent-proxy-with-ssh
Example
Put in ~/.ssh/config file (create it if it does not exist) the following:

maca (user) ===> mjost@node0 ===> cper@node4 (target) ===> root@10.0.0.7

Host node0
       Hostname node0.cloud.sophia.inria.fr
       User    mjost
Host node4
       Hostname node4.cloud.sophia.inria.fr
       User    cper
       # ForwardX11 yes
       ProxyCommand ssh -q node0 nc %h %p
       #LocalForward 0.0.0.0:8888 localhost:80
Host vm-node4
       Hostname 10.0.0.7
       User    root
       ProxyCommand ssh -q node4 nc %h %p


```

Then if you want the localhost:8888 to node4:80 to work, just login to node4 with 

```
ssh -v node4
```

and see in the logs the following: 

```
...
debug1: Local connections to 0.0.0.0:8090 forwarded to remote address localhost:8090
debug1: Local forwarding listening on 0.0.0.0 port 8090.
debug1: channel 0: new [port listener]
debug1: Local connections to 0.0.0.0:8888 forwarded to remote address localhost:80
debug1: Local forwarding listening on 0.0.0.0 port 8888.
debug1: channel 1: new [port listener]
debug1: Local connections to localhost:8085 forwarded to remote address node4.cloud.sophia.inria.fr:80
debug1: Local forwarding listening on ::1 port 8085.
debug1: channel 2: new [port listener]
debug1: Local forwarding listening on 127.0.0.1 port 8085.
...

```


# vpn through ssh
```
sshuttle -r <host-that-accesses-10.0.0.X> <mask>
sshuttle -r root@ae-openstack 10.0.0.0/24
```



# VPN-like
```
If you want to access your workstation (at work, so behind a firewall) and you have:
# a public ip machine
# your laptop 

you just run in your work workstation

while [ 0 -lt 1 ]; do sleep 3600 && ssh -f -N -R 10000:localhost:22 user@public.ip.machine.com ; done

```

# Usb bootable stick for linux

```
# Better use (GUI): 
Ubuntu -> Applications -> Other -> Startup Disk Creator
# Or (GUI too)
   $ sudo unetbootin
# Or (GUI too)
   $ sudo liveusb-creator
# Or if you want to do it the console way: 
   $ sudo dd if=ubuntu.iso of=/dev/sdb
   $ sudo sync 
   $ sudo eject /dev/sdb

```
# Create backup of a partition
keywords partition create backup restore linux windows 

## Use partimage

```
$ sudo partimage 

if blocked somewhere press ctrl+[

```

# Aliases 

```
alias rrr='ls -lah'                                      creates an alias to replace a command
unalias rrr                                              removes the alias rrr
alias                                                     shows the current alias


Add in .bashrc 

alias gitlog='git log --name-only --full-history'
alias top='top -c'

```
# Networking
## Add gateway to host
keywords networking add route table gateway 

```
sudo route add default gw 192.168.1.1 eth0

```
## Add DNS server to host
keywords networking dns domain name server set configure 
In  /etc/resolv.conf add
```
nameserver 192.168.1.16
```

## Find out what is your gateway before modifying what DHCP has done. 
```
   $ route -n 
```
The gateway is shown always with destination 0.0.0.0.
## Add a particular host
```
   $ sudo route add -host 10.1.244.17 dev tun0
```
## Add the gateway later
```
   $ sudo route add default gw 172.20.10.1 wlan0
```

## Delete a target (can be a host or a network)
```
   $ sudo route del <destination>
```



Uso practico, despues de iniciar una VPN (red donde no hay internet) esta es seteada como gateway, cortando el acceso a Internet. Como resolver esto?
```
mjost@pepa:~/bin/vpn$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         0.0.0.0         0.0.0.0         U     0      0        0 tun0 <<< GW
169.254.0.0     0.0.0.0         255.255.0.0     U     1000   0        0 wlan0
172.30.253.32   0.0.0.0         255.255.255.224 U     0      0        0 tun0
192.168.0.0     0.0.0.0         255.255.255.0   U     9      0        0 wlan0
195.220.129.158 192.168.0.1     255.255.255.255 UGH   0      0        0 wlan0

mjost@pepa:~/bin/vpn$ sudo route del -net 0.0.0.0 # borrado el GateWay en rojo
mjost@pepa:~/bin/vpn$ sudo route add -net 0.0.0.0 gw 192.168.0.1 wlan0 # agrega gateway

```
# Virtual machines
```
Install kvm
$ sudo apt-get install qemu-kvm

$ qemu-img create -f qcow2 ./my_image.qcow2 10G
$ sudo kvm -m 2048 -cdrom debian-6.0.4-amd64-netinst.iso -drive file=./my_image.qcow2,boot=on -boot d -nographic -vnc :1

```
# Open an SSH tunnel with clouding to export VNC output:
```
$ ssh -L5901:localhost:5901 clouding
$ vncviewer localhost:1
```


# CUSTOMIZING

```
Gnome normal, Main 2-consoles 3-browsers 4-Other
alt+x to switch to the x-<workspace>
use okular for pdf annotations annotate edit

keywords cron crontab howto schedule linux
Using cron

crontab -e

and add to run a command every 15 minutes
*/15 * * * * /path/to/command


this is a test


learning awesome (window manager)
keywords lightweight windows manager awesome
shortcuts

MOD4=WIN key
client=application
tab=screen
layout=way clients are shown in a screen

MOD4+r -> run command line
MOD4+space -> change layout
MOD4+j -> switch client (client = app)
MOD4+(1-9) -> switch tab (tab=screen)
MOD4+f -> make full screen the current client
MOD4+click on tab -> move current client to selected tab
MOD4+h -> increase client size
MOD4+l -> decrease client size
MOD4+ESCAPE -> switch layouts
MOD4+shift+j -> switch clients in layout
MOD4+shift+c -> kill client
MOD4+ctrl+space -> toggle floating client 
MOD4+left_mouse_button -> resizes (in floating mode)

```

# Installing webfs
```
keywords: HTTP file serfer 
  $ sudo apt-get install webfs
  $ usermod -a -G www-data YOURUSER	# add YOURUSER to the webfs group
  $ groups YOURUSER			# check your user is in webfs group
  $ sudo vim /etc/webfsd.conf		# set it up
  $ sudo service webfs restart
  $ sudo mkdir /srv/ftp
  $ sudo chown www-data:www-data -R /srv/ftp
  $ chmod g+rwxs /srv/ftp/
then logout and login so that your permissions on the group refresh

Or simply use 

python -m SimpleHTTPServer


```
# Regarding networking
```
ifup wlan0                      put up wifi interface
ifconfig eth0 up              put really up wired interface
ifdown eth0                    put down ethernet interface
ifconfig wlan0 up             put really up the wifi interface 

wpa_action wlan0 down   put down wlan0 interface, using wpa-roam package (more complete for wifi connections)
wpa_action wlan0 up
wpa_cli status

dhclient wlan0                 starts the dhcp handshake 

ifconfig interface_name up (turns on the given interface)
ifconfig interface_name down (turns off the given interface)
dhclient interface_name (makes the given interface work with DHCP)
important packages to install: ifupdown spasupplicant wireless_tools
service stop network-manager      to avoid interference with ours, ifup and ifdown (from package ifupdown)
service start network-manager      if we want the default network manager to work
/etc/init.d/network-manager stop
iwlist scan                      scan wifi networks
once the right network is found, we will use (so install them both with aptitude) ifupdown and wpasupplicant packages.

Normal procedure to get wifi working: 
sudo wpa_supplicant -iwlan0 -c./mydocs/linux/config/wpa-roam.conf -d
and paralelly...
sudo dhclient wlan0
where in wpa-roam.conf we added (to examples)  

..........................
network={
ssid="anastasias_essid"
psk="thisismynetworkpassword"
id_str="home_id_name"
}

network={
        ssid="eduroam"
        scan_ssid=1
        key_mgmt=WPA-EAP
        eap=TTLS
        anonymous_identity="anonymous@inria.fr"
        identity="mjost"
        password="passwordhere"
        phase2="auth=PAP"
}
..........................

And, to the /etc/network/interfaces add the following:

..........................
allow-hotplug wlan0
iface wlan0 inet manual
       wpa-roam /etc/wpa_supplicant/wpa-roam.conf
..........................


```
# CYGWIN
Installing cygwin from Windows commandline: 
setup-x86_64.exe -q -P vim,openssh,wget,unzip,python -s http://box-soft.com


Compile standalone library to use in clusters
keywords cluster static compile standalone screen gcc build executable library 
1. download src
2. execute: LDFLAGS="-static" ./configure
3. execute: make
4. that is all folks

```
ffmpeg compilation
wget http://ffmpeg.org/releases/ffmpeg-2.3.3.tar.bz2
tar -xvf http://ffmpeg.org/releases/ffmpeg-2.3.3.tar.bz2
cd ffmpeg-2.3.3
sudo apt-get install yasm
./configure 
make -j


```

# Linux quota


```
repquota /
```

Will show you are not using quota in your mount.

In your /etc/fstab add either usrjquota or usrquota in the options. Mine looked like this: 
```
LABEL=cloudimg-rootfs  /   ext4  defaults          0 0
and after the change looked like this:
LABEL=cloudimg-rootfs  /   ext4  defaults,usrquota 0 0

mount -o remount /
touch aquota.user
chmod 600 aquota.user
chown root:root aquota.user
quotacheck -auvm
# this will recreate the file using quota version vfsv0
quotacheck -cfmvF vfsv0 /

```

# check disk usage per user
```
repquota
```
# fix quota potential problems
```
quotacheck -avug
```

#Then you might need to put on the quota to actually limit users disk space:
```
quotaon -pguv -F vfsv0 -a
```

If quota fails you might need to do 
```
install linux-image-extra-virtual
modprobe quota_v2 and modprobe quota_v1
```

http://askubuntu.com/questions/109585/quota-format-not-supported-in-kernel


# Use alternatives tool 

Maintain symbolic links determining default commands.

```
update-alternatives

update-alternatives --list java
  /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
update-alternatives --install /usr/bin/java java  /usr/lib/jvm/zips/jdk1.8.0_151/bin/java 2 # because 1 is taken by openjdk
update-alternatives --config java 

```

# SGID bito

Assume a directory d has SGID bit enabled, and group owner G.
If a new file is created under d, such file f will have SGIT enabled too, and a group owner G.

```
set -u
set -x
set -e

rm -fr test-* 

# (Re)Create user
#sudo deluser --force ftpmstr
#sudo rm -fr /home/ftpmstr/
#sudo useradd -d /home/ftpmstr -m -s /bin/bash ftpmstr

# Create dirs
mkdir -p test-sgid

# Change permissions
sudo chgrp ftpmstr test-sgid
sudo chmod 2775 test-sgid

# Play with them
touch test-sgid/a
mkdir -p test-sgid/1/2/3
```
