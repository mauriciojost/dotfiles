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
  local fn=$tmpd/dist-upgrade.$(date '+%Y-%m-%d-%H-%M-%S').log
  date &>> $fn
  echo "installed before" &>> $fn
  apt list --installed &>> $fn
  echo "upgradable before" &>> $fn
  apt list --upgradeable &>> $fn
  sudo apt-get dist-upgrade
  echo "installed after" &>> $fn
  apt list --installed &>> $fn
  echo "upgradable after" &>> $fn
  apt list --upgradeable &>> $fn
}
