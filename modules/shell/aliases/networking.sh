function qnetwork-discover-in-10.0.0.0(){
    sudo nmap -sn 10.0.0.0/24 $@
}
function qnetwork-discover-in-192.168.0.0(){
    sudo nmap -sn 192.168.0.0/24 $@
}
function qnetwork-usage(){
    echo "Use t to switch views"
    sleep 1
    sudo iftop $@
}
function qnetwork-usage-with-mask(){
    echo "Use t to switch views, provide parameter like 10.0.0.0/32"
    sleep 1
    sudo iftop -F $1
}
