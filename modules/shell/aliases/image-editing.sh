function qimage-crop-in-out-offset() {
	local inim=$1
	local outim=$2
	local how=$3
	convert -crop "$how" "$inim" "$outim"   
}

function qplantuml() {
	local jarfile="$DOTFILES/modules/plantuml/plantuml.jar"
	if [ -e "$jarfile" ]
	then
		java -jar "$jarfile" $@
	else
		echo "Installation required."
		cat "$DOTFILES/modules/plantuml/README.md"
	fi
}
