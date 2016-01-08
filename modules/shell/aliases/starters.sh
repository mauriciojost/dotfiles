
alias qcron-env-execute-command='env - '
alias qimage-view='gwenview "$PWD"'
alias qconfigure-ubuntu-tweak=ubuntu-tweak
alias qmonitor='conky'
alias qconfiguration-gnome-control-center='gnome-control-center'
alias qusers-configuration-gui='users-admin' # Install gnome-system-tools before
alias qdisk-usage-analyzer="xdiskusage $PWD"
alias qwebdav-client=cadaver
alias qyoutube-download=youtube-dl
alias qmarkdown=haroopad
alias qmedia-server-xbmc='xbmc -fs'

function qexplore() {
	ranger $PWD  
}

function qexplore-gui () {
	nautilus --no-desktop $PWD &
}


function qyoutube-dropbox-download() {
	TARGET="$HOME/dropbox"
	CURRDIR=`readlink -e $PWD`
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

function qintellij-start() {
	IDEA=$HOME/opt/idea/bin/idea.sh
	nohup $IDEA &> /tmp/idea.log &
}

