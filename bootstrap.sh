#!/usr/bin/env bash

ETC=$HOME/.local/etc
BIN=$HOME/.local/bin
mkdir -p $ETC
mkdir -p $BIN

# git clone respository
cd $HOME/.local/
if [ -d dotfiles ]; then
    cd dotfiles
    git pull
else
    git clone https://github.com/SenZhangAI/dotfiles
    cd dotfiles
fi

cp -rf etc/* $ETC/
cp -rf bin/* $BIN/
cp bootstrap.sh $BIN/

# source init.sh, move to the end line
sed -i "\:$ETC/bash/init.sh:d" $HOME/.bashrc
echo ". $ETC/bash/init.sh" >> $HOME/.bashrc
source $HOME/.bashrc
