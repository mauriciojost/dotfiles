
function qdate-update-france() {
	sudo ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
	sudo ntpdate pool.ntp.org
}

function qmount-android-mtp() {
	DIRA="android-mount"
	rm -fr $DIRA
	mkdir -p $DIRA
	echo "### Will be mounted at: $DIRA"
	echo "### If required, umount with: sudo umount -f $DIRA && rmdir $DIRA"
	sleep 5 && nautilus --no-desktop $DIRA & 
	go-mtpfs $DIRA 
}

function qmount-iso() {
	sudo mkdir -p /media/iso
	sudo mount -o loop $1 /media/iso
	echo mounted at /media/iso
}

function qwebpage-download-as-pdf() {
	FILE="$RANDOM-$RANDOM.pdf"
	wkhtmltopdf "$1" "$FILE"
	echo "Downloaded to $FILE ..."

	if [ -z "$2" ]
	then

		echo "Calling again..."
		shift
		qwebpage-download-as-pdf $@
		
	fi
}

# Mails
function qmail-send-to-with-attachment-file() { 
	if [ -z "$1" ]
	then
		echo "Missing TO (parameter 1)" 
		return 1
	fi
	if [ -z "$2" ]
	then
		echo "Missing ATTACHMENT (parameter 2)" 
		return 1
	fi
	SUBJECT="WITH-ATTACHMENT-$RANDOM"
	mutt -a "$2" -s "$SUBJECT" "$1" 
}
