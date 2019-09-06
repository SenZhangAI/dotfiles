#!/usr/bin/env bash

#include once
if [ -z "$_SMART_INSTALL_LOADED" ]; then
    _SMART_INSTALL_LOADED=1
else
    return 0
fi

origin_base_dir=$base_dir
base_dir=$(dirname "${BASH_SOURCE[0]}")
source $base_dir/platform.sh
source $base_dir/print.sh
base_dir=$origin_base_dir

command_not_installed() {
    printf "%-48s" "Check command $1..."
    command -v $1 >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        printf "$(RED "Not Installed")\n"
        return 0
    else
        printf "$(GREEN "Installed")\n"
        return 1
    fi
}

command_installed() {
    printf "%-48s" "Check command $1..."
    command -v $1 >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        printf "$(RED "Not Installed")\n"
        return 1
    else
        printf "$(GREEN "Installed")\n"
        return 0
    fi
}

case $SYSTEM in
    Cygwin*)
        __INSTALL__="apt-cyg install "
        ;;
    Msys2*)
        __INSTALL__="pacman -Sy "
        ;;
    Ubuntu*)
        __INSTALL__="pacman -Sy "
        ;;
    CentOS*)
        __INSTALL__="yum install -y "
        #todo
        ;;
    macOS*)
        __INSTALL__="brew install "
        ;;
esac

smart_install() {
    eval "$__INSTALL__ $@"
}

must_install() {
    if command_not_installed $1; then
        printf "\033[33m$1\033[0m need to be installed first!\n"
        exit 233
    fi
}

auto_install() {
    if command_not_installed $1; then
        smart_install $1
    fi
}

