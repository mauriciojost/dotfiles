
# Wifi stuff
alias qwifi-list='iwlist wlan0 scanning | grep ESS'
alias qwifi-list-extended='iwlist wlan0 scanning'
alias qwifi-get-status='sudo wpa_cli status'

function qeth-re-start(){
	sudo killall wpa_supplicant
	sudo service network-manager restart
}

function qwifi-re-start(){
	set -x 
	sudo service network-manager stop 
	sudo killall dhclient
	sudo killall wpa_supplicant 
	sudo ifdown wlan0  
	sudo ifup wlan0
	sudo wpa_supplicant -iwlan0 -c$HOME/.wpa-roam.conf -d | tee /tmp/wpasup.log & 
	sleep 5 
	sudo dhclient wlan0 
	sleep 5 
	set +x
}
