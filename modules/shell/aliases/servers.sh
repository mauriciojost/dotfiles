function qx-display-lightdm-stop() {
    sudo service lightdm stop
}

function qx-display-lightdm-start() {
    sudo service lightdm start
}

function qps() {
    local tmp1=`mktemp`
    local tmp2=`mktemp`
    local tmp3=`mktemp`
    local tmp4=`mktemp`
    echo $tmp1
    echo $tmp2
    echo $tmp3
    echo $tmp4
    local cmd_length=80
    local filter=$1
    ps -U $USER -k-%cpu -eo pid=PID,%cpu=CPU_PERC,thcount=NRO_THREADS,vsz=VIRTUAL_MEM_KB,rss=RESIDENT_MEM_KB,pri=PRIORITY,euser=USER,etime=TIME,cmd=LONG > $tmp1
    if [ -z "$filter" ]
    then
	cat $tmp1 >> $tmp4
    else
	cat $tmp1 | grep $filter >> $tmp4
    fi
    vd --csv-delimiter ' ' --default-width 10 --filetype csv --header 1 $tmp4
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
