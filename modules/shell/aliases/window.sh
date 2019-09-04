function qwindow-pid() {
    xprop _NET_WM_PID | awk '{print $3}' | xargs -I% zenity --info --text=% --title="PID"
}

alias qwindow-kill='xkill'
