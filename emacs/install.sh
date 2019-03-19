#!/usr/bin/env bash


base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $base_dir/../utils/smart_install.sh

if command_not_installed emacs; then
    smart_install emacs
fi

echo "[Config] .emacs.d"
mkdir -p $HOME/.emacs.d
cp -r $base_dir/emacs.d/* $HOME/.emacs.d/

# vim:st=4:sw=4
