#!/usr/bin/env bash

case $OSTYPE in
    cygwin*)
        __INSTALL__="__cygwin_install "
        ;;
    msys*)
        __INSTALL__="pacman -Sy "
        ;;
    linux*)
        #todo
        ;;
    darwin*)
        __INSTALL__="brew install "
        ;;
esac

__cygwin_install() {
    echo "Sorry, cygwin can not install [$1] automatically, Please install by cygwin installer"
}

smart_install() {
    $__INSTALL__ $1
}

command_not_installed() {
    echo "Check if [$1] installed..."
    found=$(which $1 2>/dev/null)
    if [ -z "$found" ]; then
        echo -e "\t------- No"
        return 0
    else
        echo -e "\t------- Yes"
        return 1
    fi
}
