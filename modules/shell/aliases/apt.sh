function qpackage-list-files() {
	qassertnotempty "$1" "Arguments: <package-name>"
	dpkg -L "$1"
}

alias qpackage-list-last-installed='cat /var/log/dpkg.log | grep "\ install\ "'

alias qpackage-what-package-provides-the-file='apt-file search'

alias qyum-provides='apt-file search'

