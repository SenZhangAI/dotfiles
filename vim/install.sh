#!/usr/bin/env bash

echo "[Config] .ideavimrc"

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

case $OSTYPE in
    cygwin*)
        cp $base_dir/ideavimrc $(cygpath -w $USERPROFILE/.ideavimrc)
        ;;
    darwin*)
        cp $base_dir/ideavimrc $HOME/.ideavimrc
        ;;
    linux*)
        cp $base_dir/ideavimrc $HOME/.ideavimrc
        ;;
esac


# vim:st=4:sw=4
