#!/usr/bin/env bash
#
# This script will install some configuration files by creating symbolic links at $HOME .

CURRDIR="`dirname $0`"
cd $CURRDIR
DOTFILES_ROOT="`pwd`"

set -e

echo "For: rename-xfce-workspace"
sudo apt-get install wmctrl

echo "For: stderred"
sudo apt-get install build-essential cmake
cd $DOTFILES_ROOT/modules/stderrred/
make
cd $DOTFILES_ROOT

echo "For: ulauncher -> follow the intstructions in the corresponding module"

echo "For: fzf"
modules/fzf/fzf/install

echo "For: keyboard"
sudo cp $DOTFILES/modules/keys-remap/keyboard /etc/default/keyboard

echo "For: privates"
cd $DOTFILES_ROOT/modules/privates/
bash install.sh

cd $DOTFILES_ROOT

echo ''
echo '  All installed!'
