function qimage-crop-in-out-offset() {
	local inim=$1
	local outim=$2
	local how=$3
	convert -crop "$how" "$inim" "$outim"   
}

function qdiagram-plantuml() {
	local jarfile="$DOTFILES/modules/plantuml/plantuml.jar"
	if [ -e "$jarfile" ]
	then
		echo "Running java -jar "$jarfile" $@"
		java -jar "$jarfile" $@
	else
		echo "Installation required."
		cat "$DOTFILES/modules/plantuml/README.md"
	fi
}

function qdiagram-scala() {
	local executable="$DOTFILES/modules/scaladiagrams/scaladiagrams/scaladiagrams"
	if [ -e "$executable" ]
	then
		echo "Running $executable $@"
		"$executable" $@
	else
		echo "Installation required."
		cat "$DOTFILES/modules/scaladiagrams/README.md"
	fi
}
