#!/usr/bin/env bash
#
# This script will install some configuration files by creating symbolic links at $HOME .

CURRDIR="`dirname $0`"
cd $CURRDIR
DOTFILES_ROOT="`pwd`"

set -e

cd $DOTFILES_ROOT

brew install fzf
fzf --bash > ~/.fzf-key-bindings.bash

echo ''
echo '  All installed!'
