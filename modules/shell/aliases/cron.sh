
function qcron-edit () {
	crontab -e
}
function qcron-execute-command-test() {
	env - $@ 
}

