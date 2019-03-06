#!/usr/bin/env bash

#include once
if [ -z "$_UTILS_LOADED" ]; then
    _UTILS_LOADED=1
else
    return
fi

origin_base_dir=$base_dir
base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $base_dir/platform.sh
base_dir=$origin_base_dir

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

command_installed() {
    printf "Check if [$1] installed..."
    found=$(which $1 2>/dev/null)
    if [ -z "$found" ]; then
        printf "%-24s Not Installed\n"
        return 1
    else
        printf "%-24s     Installed\n"
        return 0
    fi
}

case $SYSTEM in
    Cygwin*)
        __INSTALL__="apt-cyg install "
        if command_not_installed apt-cyg; then
            git clone https://github.com/transcode-open/apt-cyg.git $HOME/.local
        fi
        ;;
    Msys2*)
        __INSTALL__="pacman -Sy "
        ;;
    Ubuntu*)
        __INSTALL__="pacman -Sy "
        ;;
    Centos*)
        __INSTALL__="yum install -y "
        #todo
        ;;
    macOS*)
        __INSTALL__="brew install "
        ;;
esac

smart_install() {
    $__INSTALL__ $@
}

