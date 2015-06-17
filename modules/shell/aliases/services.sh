
function qservice-start() {
	sudo service $1 start
}

function qservice-restart() {
	sudo service $1 restart
}

function qservice-stop() {
	sudo service $1 stop
}

function qservice-install-boot() {
	sudo update-rc.d $1 defaults
}

function qservice-remove-boot() {
	sudo update-rc.d $1 remove
}

function qservice-enable-boot() {
	sudo update-rc.d $1 enable
}

function qservice-disable-boot() {
	sudo update-rc.d $1 disable
}
