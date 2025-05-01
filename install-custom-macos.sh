#!/usr/bin/env bash
#
# This script will install some configuration files by creating symbolic links at $HOME .

CURRDIR="`dirname $0`"
cd $CURRDIR
DOTFILES_ROOT="`pwd`"

set -e

cd $DOTFILES_ROOT

echo ''
echo '  All installed!'
