#!/bin/bash -i

if [ -z $(which git 2>/dev/null) ]; then
    printf "\033[32mgit\033[0m need to be installed first!\n"
    exit 233
fi

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

source utils/platform.sh

cp -rf etc/* $ETC/
cp -rf bin/* $BIN/

if system_is cygwin;then
    cp bin/cygwin/* bin/
fi

cp bootstrap.sh $BIN/

# source init.sh, move to the end line
sed -i "\:$ETC/bashrc.sh:d" $HOME/.bashrc
echo "source $ETC/bashrc.sh" >> $HOME/.bashrc
source $HOME/.bashrc

echo "done."
