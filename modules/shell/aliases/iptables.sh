function qiptables-show(){
	iptables -L
}
function qiptables-save-current-config(){
    service iptables save
}

