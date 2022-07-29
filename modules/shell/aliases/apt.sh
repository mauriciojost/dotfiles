function qpackage-list-files() {
	qassertnotempty "$1" "Arguments: <package-name>"
	dpkg -L "$1"
}

alias qpackage-list-last-installed='cat /var/log/dpkg.log | grep "\ install\ "'

alias qpackage-what-package-provides-the-file='apt-file search'

alias qyum-provides='apt-file search'


function qdist-upgrade() {
  local tmpd=~/.logs
  mkdir -p $tmpd 
  local fn=$tmpd/dist-upgrade.$(date '+%Y-%m-%d-%H-%M-%S')

  local fnbefore=$fn.before.log
  date &>> $fnbefore
  echo "installed before" &>> $fnbefore
  apt list --installed | sort &>> $fnbefore
  echo "upgradable before" &>> $fnbefore
  apt list --upgradeable | sort &>> $fnbefore

  local fnduring=$fn.during.log
  sudo apt-get dist-upgrade -y &>> $fnduring

  local fnafter=$fn.after.log
  date &>> $fnafter
  echo "installed after" &>> $fnafter
  apt list --installed | sort &>> $fnafter
  echo "upgradable after" &>> $fnafter
  apt list --upgradeable | sort &>> $fnafter
}
