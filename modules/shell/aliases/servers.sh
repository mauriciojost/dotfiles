function qx-display-lightdm-stop() {
    sudo service lightdm stop
}

function qx-display-lightdm-start() {
    sudo service lightdm start
}

function qvpn-over-ssh-using-server-X() {
	if [ -z "$1" ]
	then
		echo "Must provide server (from .ssh/config or user@server form) "
	else 
		set -x
		sshuttle -H -r "$1" -N -v
		set +x 
	fi
}

function qhttp-expose-this-folder-on-port {
    PORT="$1"
    echo "See http://`hostname`:$PORT"
    python -m SimpleHTTPServer $PORT
}

function qrsync() {
	SOURCE=$1
	TARGET=$2
	rsync -avzP --delete --recursive $SOURCE $TARGET
}

function qrsync-with-checksum() {
	SOURCE=$1
	TARGET=$2
	rsync -avzP --checksum --delete --recursive $SOURCE $TARGET
}

function qrsync-simulate() {
	SOURCE=$1
	TARGET=$2
	rsync -avzP --dry-run --itemize-changes --checksum --delete --recursive $SOURCE $TARGET
}

function qmount-over-ssh-using-server-X-and-localmount-Y() {
	SERVER=$1
	MOUNT=$2
    sshfs $SERVER $MOUNT 
}
