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

function qcertificate-get-server-port() {
  local servername="$1"
  local serverport="$2"
  local extension="${3:-pem}"
  local f=/tmp/$servername.$serverport.certfile.$extension
  openssl s_client -showcerts -connect $servername:$serverport </dev/null 2>/dev/null|openssl x509 -outform PEM > $f
  echo "$f"
}

function qcertificate-install-server-port() {
  local servername="$1"
  local serverport="$2"
  f="$(qcertificate-get-server-port $servername $serverport crt)"
  # From https://unix.stackexchange.com/questions/90450/adding-a-self-signed-certificate-to-the-trusted-list
  echo "Now: "
  echo "sudo cp $f /usr/local/share/ca-certificates/"
  echo "sudo update-ca-certificates"
  echo "certutil -d sql:$HOME/.pki/nssdb -A -t \"C,,\" -n \"$servername $serverport at $f\" -i $f"
}

function qjava-trust-pkix-server-port() {
  local servername="$1"
  local serverport="$2"
  local jre_lib_security_cacerts_dir="$3"
  if [ -z "$jre_lib_security_cacerts_dir" ]
  then
    echo "Must provide the cacerts directory (probably $(realpath $(which java) | sed 's#/bin/java#/jre/lib/security/cacerts#') to be created if does not exist)"
  else
    echo "Getting certificate of $servername port $port..."
    f=$(qcertificate-get-server-port $servername $serverport)
    echo "Adding certificate to $jre_lib_security_cacerts_dir..."
    echo "Default password: changeit"
    keytool -importcert -file $f -alias "${servername}_${serverport}" -keystore $jre_lib_security_cacerts_dir
  fi
}
