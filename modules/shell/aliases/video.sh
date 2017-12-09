
alias qrecord-screen-video=simplescreenrecorder

#function qvideo-process-simple-input-output() {
#	mencoder $1 -oac pcm -ovc x264 -o $2
#}


function qvideo-process-simple-input-output() {
	echo mencoder input.mp4 -ovc x264 -vf crop=largopx:anchopx:x:y -frames amount_of_frames_to_read -o output.mp4 
}

function qvideo-process-crop-time-input-output-fromtime-untiltime() {
	echo mencoder $1 -ovc x264 -o $2 -ss $3 -endpos $4
}

function qvideo-downsample-gui() {
    echo "http://avidemux.sourceforge.net/download.html"
	avidemux $@
}
#function qvideo-downsample-mp4input-screensize() {
#	FILE="/tmp/video-$RANDOM-$RANDOM.mp4"
#
#	if [ -z "$2" ]
#	then
#		echo 'Scale not provided, using default'
#		SCALE="100:80"
#	else 
#		SCALE="$2"
#	fi
#
#	set -x 
#	echo "Generating video at: $FILE with scale $SCALE"
#	#mencoder "$1" -ovc lavc -vf scale=$SCALE -oac pcm -o "$FILE"
#	~/bin/ffmpeg -i "$1" -s $SCALE -b 512k -vcodec mpeg1video -acodec copy "$FILE"
#	set +x 
#	echo "Generated video at: $FILE with scale $SCALE"
#}


function qvideo-crop-mp4input-from-to() {
	qvideo-downsample-mp4input "$1" "scale=iw:ih" "$2" "$3"
}

function qvideo-downsample-half-mp4input() {
	qvideo-downsample-mp4input "$1" "scale=iw/2:ih/2" "00:00:00" "23:59:59"
}

function qvideo-downsample-quarter-mp4input() {
	qvideo-downsample-mp4input "$1" "scale=iw/4:ih/4" "00:00:00" "23:59:59"
}

function qvideo-downsample-smaller-mp4input() {
	qvideo-downsample-mp4input "$1" "scale=iw*3/4:ih*3/4" "00:00:00" "23:59:59"
}

function qvideo-downsample-mp4input() {
	SOURCE=`readlink -e "$1"`
	BASENAME=`basename "$SOURCE"`
	FILE="/tmp/video-$BASENAME-$RANDOM-$RANDOM.mp4"
	SCALE="$2"
	START="$3"
	FINISH="$4"

	echo "Generating video at: $FILE"
	ffmpeg -i "$SOURCE" -vf $SCALE -acodec mp2 -ss $START -to $FINISH  "$FILE"
	echo "Generated video at: $FILE"
	ls -lah "$FILE" "$SOURCE"
	echo "To replace:   mv \"$FILE\" \"$SOURCE\""
}

