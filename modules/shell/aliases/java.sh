alias jps='jps -l'

function qjava-jar-list-all-classes() {

	TMPFILEINT=/tmp/find-class-$RANDOM.txt
	TMPFILEOUT=/tmp/find-class-$RANDOM-out.txt

	echo "Looking for JAR files in sub-folders..."
	find -name '*.jar' > $TMPFILEINT
	echo "Done. Result in $TMPFILEINT . "
	echo "Listing classes in $TMPFILEOUT ."

	rm -f $TMPFILEOUT

	exec<$TMPFILEINT
	while read FILE
	do
		echo "   $FILE"
		echo "" >> $TMPFILEOUT
		echo "###" $FILE "###" >> $TMPFILEOUT
		sleep 0.1
		jar -tvf $FILE >> $TMPFILEOUT
		echo "" >> $TMPFILEOUT
	done

	echo "Done. Result at $TMPFILEOUT . "
	sleep 1
}

function qjava-killall() {
	jps | grep $1 | awk '{print $1}' | xargs -I% kill -9 %
}


### GVM

function qgradle-gvm-init() {
	source $HOME/.gvm/bin/gvm-init.sh
}

