function qimage-crop-in-out-offset() {
	local inim=$1
	local outim=$2
	local how=$3
	convert -crop "$how" "$inim" "$outim"   
}

function qdiagram-plantuml() {
	local binfile=`which plantuml`
	if [ -e "$binfile" ]
	then
		plantuml $@
	else
		echo "Installation required: sudo apt-get install plantuml"
		cat "$DOTFILES/modules/plantuml/README.md"
	fi
}

function qdiagram-scala() {
	local executable="$DOTFILES/modules/scaladiagrams/scaladiagrams/scaladiagrams"
	if [ -e "$executable" ]
	then
		"$executable" $@ | dot -Tpng > output.png
		"$executable" $@ > output.dotfile
	else
		echo "Installation required."
		cat "$DOTFILES/modules/scaladiagrams/README.md"
	fi
}

function qdiagram-mermaid() {
	echo "Packages here: https://unpkg.com/mermaid@7.1.0/dist/"
	echo "Examples here: https://github.com/knsv/mermaid"
	echo "Live editor: https://mermaidjs.github.io/mermaid-live-editor/"
	gop $DOTFILES/modules/mermaid/index.html
}

