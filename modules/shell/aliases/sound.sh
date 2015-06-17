
# Change volume of system
alias qvolume='pavucontrol'
alias qvolume-list-sinks='pactl list short sinks'
alias qvolume-set-default-sink='pacmd set-default-sink'
alias qvolume-list-sinkinputs='pactl list short sink-inputs'
alias qvolume-set-sink-volume-zero-to-64k-for-100-percent='pacmd set-sink-volume'
alias qvolume-move-sinkinput-to-a-given-sink='pactl move-sink-input'
alias qvolume-list-cards-and-devices='aplay -L'
alias qvolume-list-card-profiles='pacmd list-cards'
alias qvolume-set-card-and-card-profile='pactl set-card-profile' 

function qrecord-sound-remote() {
	HOST=$1
	FILE="/tmp/record-$RANDOM-$RANDOM-$RANDOM.mp3"
	echo "Recording at $HOST to $FILE..."
	ssh $HOST bash -c "record -f cd -d 10 -t raw | lame -x -r - > $FILE"
	echo "Recorded, copying to local host..."
	scp $HOST:$FILE $FILE
	echo "Copied. Playing..."
	gop $FILE
	echo "Done."
}

function qvolume-set-default-device() {
	echo "Identify your device: "
	echo ""
	sleep 1
	echo "Ready?"
	echo ""
	sleep 2
	aplay -L | less
	sleep 7
	echo "Now you will have to configure default.pa as follows: load-module module-alsa-sink device=<device name>"
	echo "Example:                                              load-module module-alsa-sink device=hw:0,1"
	echo ""
	sleep 3
	sudo vim /etc/pulse/default.pa
	echo "Configuration done..."
	sleep 3
 	echo "Restarting pulseaudio..."
	pulseaudio -k && sudo alsa force-reload
	# killall pulseaudio
	# pulseaudio & 
	sleep 2
	echo ""
	aplay $HOME/.dotfiles/samples/sample.wav
	echo ""
	echo "Done. Now you might have to restart applications to reconnect to the new instance of pulseaudio..."
}

