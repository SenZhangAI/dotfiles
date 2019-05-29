#!/usr/bin/env bash

echo -e "[Check] \033[32mgit global user.email\033[0m configured?"

search=`git config --global user.email`

    echo "[Config] user.email"
if [ -z "$search" ]; then
    echo -e "Not Found.\n"
    git config --global user.email "szhang.hust@gmail.com"
else
    echo -e "Found.\n"
fi

echo -e "[Check] \033[32mgit global user.name\033[0m configured?"

echo "[Config] user.name"
search=`git config --global user.name`
if [ -z "$search" ]; then
    git config --global user.name "Sen Zhang"
else
    echo -e "Found.\n"
fi


echo "[Config] save username and password"
# store username and password so I won't need to type username and password again.
#git config --global credential.helper 'cache --timeout 7200'
git config --global credential.helper store

echo "[Config] enable color"
git config --global color.ui true

# vim:st=4:sw=4
