#!/usr/bin/env bash

#include once
if [ -z "$_UTILS_LOADED" ]; then
    _UTILS_LOADED=1
else
    return
fi

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

case $OSTYPE in
    cygwin*)
        __INSTALL__="apt-cyg install "
        if command_not_installed apt-cyg; then
            git clone https://github.com/transcode-open/apt-cyg.git $HOME/.local
        fi
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

