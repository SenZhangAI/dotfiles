#!/usr/bin/env bash

echo -e "[Check] \033[32mssh\033[0m already configured?"

search=`cat $HOME/.ssh/id_rsa.pub | grep "szhang.hust@gmail.com"`

if [ -z "$search" ]; then
    echo -e "Not Found.\n"
else
    echo -e "Found.\n"
    exit 0
fi

echo "[Config]"
ssh-keygen -t rsa -b 4096 -C "szhang.hust@gmail.com"
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
clip < ~/.ssh/id_rsa.pub

# vim:st=4:sw=4
