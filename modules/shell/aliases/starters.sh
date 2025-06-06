
alias qcron-env-execute-command='env - '
alias qimage-view='gwenview "$PWD"'
alias qconfigure-ubuntu-tweak=ubuntu-tweak
alias qmonitor='conky'
alias qconfiguration-gnome-control-center='gnome-control-center'
alias qusers-configuration-gui='users-admin' # Install gnome-system-tools before
alias qwebdav-client=cadaver
alias qyoutube-download=youtube-dl
alias qmarkdown=haroopad
alias qmedia-server-xbmc='xbmc -fs'

function qyoutube-dropbox-download() {
	TARGET="$HOME/dropbox"
	CURRDIR=`realpath $PWD`
	LOGSS="/tmp/youtube-dl-$RANDOM.log"
	cd $TARGET
	nohup youtube-dl $1 &> $LOGSS
	cd $CURRDIR
	echo Downloading at $TARGET , logs in $LOGSS
}


function qjetty-run-give-position-and-port() {
	war=$1
	port=$2
	url="http://`hostname`:$port"
	echo "Available files will be:"
	for f in `ls $war`
	do
		echo "   $url/$f"
	done
	echo ""
	sleep 1
	java -jar ~/bin/zips/jars/jetty-runner.jar --port $port --out /tmp/jetty.log.out --log /tmp/jetty.log.log --path / $war
}

function qvm-kvm-start() {

	MSG="Arguments: <vm-disk-image.qcow2> <vnc-number>"
	if [ -z "$1" -o -z "$2" ]
	then
		echo $MSG
		return 
	fi

	VMDISK="$1"
	MEM="1024"
	VNC=":$2"
	LOGS=`mktemp`

	file $VMDISK

	echo "Starting VM (MEM=$MEM, VNC=$VNC, LOGS=$LOGS): $VMDISK ..."
	kvm -m $MEM -drive file=$VMDISK -boot d -vnc $VNC &> $LOGS &

	sleep 3

	echo "Starting VNC viewer (VNC=$VNC) ..."
	gvncviewer localhost$VNC &> /dev/null &

	echo "Done..."

}

function qlaunch() {
	local prcs="$@"
	local tmpf=`mktemp`
	nohup $prcs &> $tmpf &
	echo "Logging in $tmpf"
}


function qdisk-usage-analyzer() {
  local file_backup_dir=$HOME/.logs/
  local file_backup_file=$file_backup_dir/$RANDOM-$RANDOM.log

  mkdir -p $file_backup_dir

  # biggest packages
  dpigs -n 100 -S -H
  # disk usage
  xdiskusage /
  # backup status

  echo "Storing disk usage story in $file_backup_file ..."

  echo "" > $file_backup_file
  echo "### DPIGS" >> $file_backup_file
  dpigs -n 1000000 -H >> $file_backup_file
  echo "### APT LIST" >> $file_backup_file
  apt list --installed >> $file_backup_file
  echo "### DF" >> $file_backup_file
  df >> $file_backup_file
}

function qdisk-cleanup-snap() {
 #Removes old revisions of snaps
 #CLOSE ALL SNAPS BEFORE RUNNING THIS
 set -eu
 LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
     while read snapname revision; do
         echo snap remove "$snapname" --revision="$revision"
     done
}


function qdisk-cleanup() {

  sudo apt-get clean
  sudo apt-get autoremove
  sudo rm -rf /var/lib/apt/lists/*
  echo Can restore with sudo apt-get update
  sudo journalctl --vacuum-size=10M
  sudo snap set system refresh.retain=2 # make snap
  qdisk-cleanup-snap
  sudo fslint-gui

}
