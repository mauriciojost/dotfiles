function qvirtualbox-restart-clipboard-service(){
  killall VBoxClient
  VBoxClient --clipboard
}

