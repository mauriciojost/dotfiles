
function qgrub-change-default-os() {
	sudo vim /etc/default/grub
	echo "Updating grub in 5 seconds..."
	sleep 5
	sudo update-grub
}

