#!/usr/bin/env bash

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/smart_install.sh

if command_not_installed ssh; then
    smart_install openssh
fi

printf "[Check] if ssh configured?\t"

search=`cat $HOME/.ssh/id_rsa.pub | grep "szhang.hust@gmail.com"`

if [ -z "$search" ]; then
    printf "\t\t\tNot Configured.\n"
    echo "[Config] add ssh key..."
    ssh-keygen -t rsa -b 4096 -C "szhang.hust@gmail.com"
    eval $(ssh-agent -s)
    ssh-add ~/.ssh/id_rsa
else
    printf "\t\t\tConfigured.\n"
fi



command_found() {
    if [ -z "$(which $1 2>/dev/null)" ]; then
        return 1
    else
        return 0
    fi
}

_copy=""
if command_found pbcopy; then
    _copy="pbcopy "
elif command_found copy; then
    _copy="copy "
fi

if [ ! -z $_copy ]; then
    printf "[Copy] ssh pub key...\t"
    eval "$_copy < ~/.ssh/id_rsa.pub"
    printf "\t\t\t\tDone.\n"
fi
