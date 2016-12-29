function qhelp() {
	ranger $DOTFILES/docs/
}

function qhelp-search() {
    TOSEARCH="$1"
	grep -R "$TOSEARCH" $DOTFILES/docs/
}

function qaliases-edit() {
    echo "Use v to select the directory and :grep to find the alias to edit..."
    sleep 0.5
	ranger $DOTFILES/modules/shell/
	source $HOME/.bashrc
}

function qsettitle() {
	export PROMPT_COMMAND='echo -ne "\033]0;'$1'\007"; '$PROMPT_COMMAND
	export PS1="\u@\h:\w\$ "
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

function qremote() {
	LOCAL_FILE=/tmp/qremote-local-$RANDOM-$RANDOM-$RANDOM.tmp
	scp "$1" $LOCAL_FILE
	echo $LOCAL_FILE
}

function qtitle-set() {
	TITLE="$1"
	export PS1='\[\e]0;$TITLE\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

	export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

	#export PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	 export PS1="\[\e]0;$TITLE\a\]${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"

	#export PS1='\[\e]0;$TITLE\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

}

function qlist-latest-modified-files-20() {
	qlist-latest-modified-files | head -20
}

function qlist-latest-modified-files() {
	find $1 -type f -exec stat --format '%Y :%y %n' {} \; | sort -nr | cut -d: -f2-
}

function qhttp-expose-this-folder-on-port {
    PORT="$1"
    echo "See http://`hostname`:$PORT"
    python -m SimpleHTTPServer $PORT
}

function qfile-to-unique-line-file() {
	TARGET=$1
	cat $TARGET | tr -d '\n'
}

function qremote() {
	LOCAL_FILE=/tmp/qremote-local-$RANDOM-$RANDOM-$RANDOM.tmp
	scp "$1" $LOCAL_FILE
	echo $LOCAL_FILE
}



alias qssh-get-public-key-from-private='ssh-keygen -y -f'
function qscreensaver-init() {
	xscreensaver -no-splash &> /dev/null & 
}

function qmkdir() {
	mkdir -p "$1"
	cd "$1"
}

function qvpn-over-ssh() {
	if [ -z "$1" ]
	then
		echo "Must provide server (from .ssh/config or user@server form) "
	else 
		set -x
		sshuttle -H -r "$1" -N -v
		set +x 
	fi
}

function qrename-files-batch-erase-spaces() {
	rename 's/ //;' *
}

alias qwhat-is-my-ip-address='curl http://ipecho.net/plain'
alias qgoto-logs-dir='cd /var/log'
alias qgoto-conf-dir='cd /etc/'


# Awesome
function qawesome-edit() {

	RCLUA=$DOTFILES/config/awesome/rc.lua
	vim $RCLUA
	echo ""
	echo "Checking syntax of file..."
	awesome -k -c $RCLUA 
	sleep 2
}

function qawesome-restart() {
	awesome -k 
	echo 'awesome.restart()' | awesome-client
}

alias qlock-screen='xscreensaver-command -lock'
alias qlock-screen-config='xscreensaver-demo'
alias qcd-burner-copier='brasero'
