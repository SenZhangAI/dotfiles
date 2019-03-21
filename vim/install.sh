#!/usr/bin/env bash

echo "[Config] .ideavimrc"

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/smart_install.sh

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


check_dependent() {
    if command_not_installed vim; then
        smart_install vim
    fi

    if command_not_installed clang; then
        smart_install clang
    fi

    if command_not_installed python2; then
        smart_install python2
    fi

    if command_not_installed python3; then
        smart_install python3
    fi

    if command_not_installed gcc; then
        smart_install gcc
    fi
}

config_vim() {
    check_dependent

    vim_dir=$HOME/.vim/vim
    if [ -d $vim_dir ]; then
        cd $vim_dir
        git pull
    else
        mkdir -p $HOME/.vim
        git clone https://github.com/SenZhangAI/vim $vim_dir
        cd $vim_dir
    fi
    unset vim_dir

    ./install.sh &
    wait
    return 0
}

config_vim

# vim:st=4:sw=4
