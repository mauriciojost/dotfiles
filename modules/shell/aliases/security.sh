function qsecurity-cleanup-history-matching-single() {
  local file="$1"
  local match="$2"
  cat $file | grep -a -v "$match" > $file.new
  echo "# Done, execute this block if the stats below make sense!"
  echo "# Before: $(wc -l $file) lines"
  echo "# After : $(wc -l $file.new) lines"
  echo "rm $file && mv $file.new $file # if fine"
}

function qsecurity-cleanup-history-matching() {
  local match="$1"
  qsecurity-cleanup-history-matching-single "$CUSTOM_HISTORY_FILE" "$match"
  qsecurity-cleanup-history-matching-single "$HOME/.bash_history" "$match"
}

function qsecurity-install-certificate-linux() {
  local servername="$1";
  local serverport="$2";
  local pem_file=$servername.$serverport.cert.pem.crt
  openssl s_client -showcerts -connect $servername:$serverport < /dev/null 2> /dev/null | openssl x509 -outform PEM > $pem_file
  sudo mkdir -p /usr/local/share/ca-certificates/extra
  sudo cp $pem_file /usr/local/share/ca-certificates/extra/
  sudo update-ca-certificates
}

function qsecurity-install-all-certificats-in-linux-for-chrome() {
  # from https://thomas-leister.de/en/how-to-import-ca-root-certificate/
  # Requirement: apt install libnss3-tools
  for certfile in $(find /usr/local/share/ca-certificates/extra/ -type f)
  do
    echo "Inserting $certfile ..."
	certname="$(basename $certfile)"
	### For cert8 (legacy - DBM)
	for certDB in $(find ~/ -name "cert8.db")
	do
	  certdir=$(dirname ${certDB});
	  certutil -A -n "${certname}" -t "TCu,Cu,Tu" -i ${certfile} -d dbm:${certdir}
      echo "Inserting $certfile into $certdir..."
	done
	### For cert9 (SQL)
	for certDB in $(find ~/ -name "cert9.db")
	do
	  certdir=$(dirname ${certDB});
	  certutil -A -n "${certname}" -t "TCu,Cu,Tu" -i ${certfile} -d sql:${certdir}
      echo "Inserting $certfile into $certdir..."
	done
  done
}
