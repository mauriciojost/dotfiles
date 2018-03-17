function qhistory-list-consoles () {
	consoles=`cat $CUSTOM_HISTORY_FILE | cut -c1-33 | sed 's/ //' | sort -u`
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
    cat "$CUSTOM_HISTORY_FILE" | highlight yellow ';' | highlight green cd
}

function qhh() {
    bn=$(basename $PWD)
    qh | grep -a "$PWD" | highlight blue "$bn"
}

