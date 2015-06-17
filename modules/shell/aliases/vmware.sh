
function qvmware-reset-all() {
	sudo killall -9 vmplayer
	sudo killall -9 vmware-vmx
}

function qvmware-uninstall() {
    sudo vmware-installer -u vmware-player
}

