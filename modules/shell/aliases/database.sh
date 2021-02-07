function qdatabase-h2-explore() {
  wget https://repo1.maven.org/maven2/com/h2database/h2/1.4.200/h2-1.4.200.jar
  java -jar h2-1.4.200.jar
}

function qdatabase-explore() {
  local file=dbeaver-ce-latest-linux.gtk.x86_64.tar.gz
  if [ ! -e /tmp/dbeaver ]
  then
	mkdir -p /tmp/dbeaver
	cd /tmp/dbeaver
	wget https://dbeaver.io/files/$file
	tar -xvf *.tar.gz
  fi
  /tmp/dbeaver/dbeaver/dbeaver
}
