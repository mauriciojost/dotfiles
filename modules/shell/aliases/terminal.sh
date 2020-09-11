function qterminal-which() {
  local pid=$$
  while true; do
      pid=$(ps -h -o ppid -p $pid 2>/dev/null)
      ppid=$(ps -h -o comm -p $pid 2>/dev/null)
      case $ppid in
        (terminator) echo "terminator";return;;
        (gnome-terminal) echo "gnome-terminal";return;;
        (gnome-terminal-) echo "gnome-terminal";return;;
        (xterm) echo "xterm";return;;
        (rxvt) echo "rxvt";return;;
        (guake) echo "guake";return;;
        (python) if [ ! -z "$(ps -h -o args -p $pid 2>/dev/null | grep guake)" ]; then echo "guake"; return; fi ;;
        (python) echo "python";return;;
        (*) echo "unknown-$ppid";return;;
      esac
      [[ $(echo $pid) == 1 ]] && break
  done
}
