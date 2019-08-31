#!/usr/bin/env bash
#
# This script will install some configuration files by creating symbolic links at $HOME .

CURRDIR="`dirname $0`"
cd $CURRDIR
DOTFILES_ROOT="`pwd`"

set -e

echo "For: xfce"
mv $HOME/.config/xfce4 $HOME/.config/xfce4.bkp
ln -fs `readlink -e $DOTFILES_ROOT/modules/xfce4` $HOME/.config/xfce4

echo "For: rename-xfce-workspace"
sudo apt-get install wmctrl

echo "For: stderred"
sudo apt-get install build-essential cmake
cd $DOTFILES_ROOT/modules/stderrred/
make
cd $DOTFILES_ROOT

echo "For: ulauncher -> follow the intstructions in the corresponding module"

echo ''
echo '  All installed!'
