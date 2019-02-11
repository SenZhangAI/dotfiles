#!/usr/bin/env bash

echo "[Config] .emacs.d"

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cp -r $base_dir/emacs.d/* $HOME/.emacs.d/

# vim:st=4:sw=4
