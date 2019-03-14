#!/usr/bin/env bash

echo "[Config] .ideavimrc"

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

case $OSTYPE in
    cygwin*)
        cp $base_dir/ideavimrc $(cygpath -w $USERPROFILE/.ideavimrc)
        ;;
    msys*)
        cp $base_dir/ideavimrc $USERPROFILE/.ideavimrc
        ;;
    darwin*)
        cp $base_dir/ideavimrc $HOME/.ideavimrc
        ;;
    linux*)
        cp $base_dir/ideavimrc $HOME/.ideavimrc
        ;;
esac

config_vim() {
    mkdir -p $HOME/.vim
    {
        cd $HOME/.vim
	    git clone https://github.com/SenZhangAI/vim
	    ./vim/install.sh
    } &
    wait
    return 0
}

if [ ! -d $HOME/.vim/vim ]; then
    config_vim
fi

# vim:st=4:sw=4
