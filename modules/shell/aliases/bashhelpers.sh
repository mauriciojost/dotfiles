
function qassertnotempty() {
	if [ -z "$1" ]
	then
		echo "$2" 
		return 1
	fi
}

