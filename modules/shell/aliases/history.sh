function qhistory-list-consoles () {
	consoles=`cat $HISTORY_FILE | cut -c1-33 | sed 's/ //' | sort -u`
	for console in $consoles
	do
		echo "--------------------------------"
		echo "$console"
		echo "--------------------------------"
		cat $HISTORY_FILE | grep "$console" 
	done

}

alias qexecute-using-local-display="DISPLAY=:0 "


function qh() {
	cat $HISTORY_FILE | grep "$1"
}

function qhh() {
	qh | grep `pwd` | grep "$1"
}

