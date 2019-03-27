#!/usr/bin/env bash

echo -e "[Check] \033[32mgit global user.email\033[0m configured?"

search=`git config --global user.email`

if [ -z "$search" ]; then
    echo -e "Not Found.\n"
    echo "[Config]"
    git config --global user.email "szhang.hust@gmail.com"
else
    echo -e "Found.\n"
fi

echo -e "[Check] \033[32mgit global user.name\033[0m configured?"

search=`git config --global user.name`

if [ -z "$search" ]; then
    echo -e "Not Found.\n"
    echo "[Config]"
    git config --global user.name "Sen Zhang"
else
    echo -e "Found.\n"
fi


# store username and password so I won't need to type username and password again.
#git config --global credential.helper 'cache --timeout 7200'
git config --global credential.helper store

# vim:st=4:sw=4
