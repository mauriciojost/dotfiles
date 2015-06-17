function qimage-crop-in-out-offset() {
	inim=$1
	outim=$2
	how=$3
	convert -crop "$how" "$inim" "$outim"   
}
