function qdisplay-multiple-dvi-setup-work() {
	echo "Before..."
	xrandr
	sleep 2
	xrandr --output DVI-1 # --rotate left
	xrandr --output DVI-0 --right-of DVI-1
	echo "After..."
	xrandr
}

function qdisplay-multiple-dvi-setup-home-xbmc() {
	MONPC=LVDS1
	MONTV=HDMI1
	#MODE=1024x768
	MODE=1920x1080
	#MODE=1600x1200
	#MODE=1600x900
	#xrandr --output $MONPC --mode $MODE --output $MONTV --same-as $MONPC
	#xrandr --output $MONPC --mode $MODE --output $MONTV --mode $MODE --same-as $MONPC
	xrandr --output $MONTV --mode $MODE --output $MONPC --off 
}

function qdisplay-simple-home() {

	MONPC=LVDS1
	MONTV=HDMI1
	MODE=1600x900
	xrandr --output $MONPC --mode $MODE --output $MONTV --off 
}


function qdisplay-multiple-dvi-setup-home-divided() {
	MONPC=LVDS1
	MONTV=HDMI1
	MODEPC=1600x900
	MODETV=1920x1080
	xrandr --output $MONPC --mode $MODEPC --output $MONTV --mode $MODETV --left-of $MONPC
}
