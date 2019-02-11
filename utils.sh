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
    echo "Sorry, cygwin can not install [$@] automatically, Please install by cygwin installer"
}

smart_install() {
    $__INSTALL__ $@
}

command_not_installed() {
    printf "Check if [$1] installed..."
    found=$(which $1 2>/dev/null)
    if [ -z "$found" ]; then
        printf "%-24s Not Installed\n"
        return 0
    else
        printf "%-24s     Installed\n"
        return 1
    fi
}

