function qhistory-list-consoles () {
	consoles=`cat $HISTORY_FILE | cut -c1-33 | sed 's/ //' | sort -u`
	for console in $consoles
	do
		echo "--------------------------------"
		echo "$console"
		echo "--------------------------------"
		cat $HISTORY_FILE | grep -a "$console" 
	done

}

alias qexecute-using-local-display="DISPLAY=:0 "


function qh() {
    if [ -z "$1" ]
	then
	    echo "Must provide pattern"
	else
	    cat $HISTORY_FILE | grep -a "$1"
	fi
}

function qhh() {
    if [ -z "$1" ]
	then
	    echo "Must provide pattern"
	else
	    qh | grep -a "$PWD" | grep -a "$1"
	fi
}

