#!/bin/bash

set -x 
set -e 

TARGETDIR=output

function place() {
  BASEDIR=$1
  TARGET=$2
  TARGETD=$BASEDIR/$TARGET
  mkdir -p $TARGETD
  find -type f | grep $TARGET | xargs -I% cp -f % $TARGETD
  find -type f | grep ca.crt | xargs -I% cp -f % $TARGETD
  if [ "$(echo $TARGET | grep server)" == '' ]
  then
    echo ""
  else 
    find -type f | grep dh.pem | xargs -I% cp -f % $TARGETD
  fi

}


rm -fr ./pki
./easyrsa init-pki 
./easyrsa build-ca nopass
./easyrsa build-server-full server1 nopass
./easyrsa build-client-full client1 nopass
./easyrsa build-client-full client2 nopass
./easyrsa build-client-full client3 nopass
./easyrsa gen-dh

set +x

echo "DONE."
echo ""
echo "Put the following files in /etc/openvpn/ (for each corresponding host) for automatic startup of the daemon openvpn."

rm -fr $TARGETDIR

place $TARGETDIR server1
place $TARGETDIR client1
place $TARGETDIR client2
place $TARGETDIR client3

find $TARGETDIR

