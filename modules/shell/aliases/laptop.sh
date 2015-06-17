
function qbattery-check() {
	$HOME/.dotfiles/modules/followup/followup-plot
}

function qsleep() {
	# To avoid passwords request:
	#    - add AT THE VERY END of the sudoers file (using TABS): 
	#        UNIX_USER ALL=(ALL) NOPASSWD: /usr/sbin/pm-hibernate"
	#      for instance: 
	#        mjost ALL=(ALL) NOPASSWD: /usr/sbin/pm-hibernate"
	echo "Going to hibernate..."
	sudo pm-hibernate
	echo "Comming back from hibernate..."
}

function qpoweroff() {
	sudo poweroff
}
function qreboot() {
	sudo reboot
}
function qbacklight-set() {
	qassertnotempty "$1" "Arguments: <0-100>"
	echo "Old value: `xbacklight`"
	xbacklight -set "$1"
	echo "New value: `xbacklight`"
}

