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

function qjava-trust-pkix-server-port() {
  local servername="$1"
  local serverport="$2"
  local jre_lib_security_cacerts_dir="$3"
  if [ -z "$jre_lib_security_cacerts_dir" ]
  then
    echo "Must provide the cacerts directory (probably $(readlink -e $(which java) | sed 's#/bin/java#/jre/lib/security/cacerts#') to be created if does not exist)"
  else
    echo "Getting certificate of $servername port $port..."
    openssl s_client -showcerts -connect $servername:$serverport </dev/null 2>/dev/null|openssl x509 -outform PEM >mycertfile.pem
    echo "Adding certificate to $jre_lib_security_cacerts_dir..."
    echo "Default password: changeit"
    keytool -importcert -file mycertfile.pem -alias "${servername}_${serverport}" -keystore $jre_lib_security_cacerts_dir
  fi
}
