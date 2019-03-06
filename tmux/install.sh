#!/usr/bin/env bash

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/platform.sh
source $base_dir/../utils/smart_install.sh

case $SYSTEM in
    Centos)
        echo "check if tmux version is too old..."
        _old_tmux_version=$(tmux -V | grep "1.*")
        if [ ! -z "$_old_tmux_version" ]; then
            echo "tmux version is old: $_old_tmux_version"
            unset _old_tmux_version
            yum remove tmux
            yum install -y ncursors libevent
            cd $base_dir
            git clone --depth=1 https://github.com/tmux/tmux.git
            cd tmux
            sh autogen.sh
            ./configure && make
            cp ./tmux/tmux $HOME/bin
            rm -rf tmux
            echo "done"
        fi
        ;;
    *)
        ;;
esac

echo "Check if tmux configured..."

if [ -d "$HOME/.tmux" ]; then
    echo -e "Yes.\n"
else
    echo -e "No.\n Config tmux..."
    cd $HOME
    git clone --depth=1 https://github.com/gpakosz/.tmux.git
    ln -s -f .tmux/.tmux.conf
    cp .tmux/.tmux.conf.local .
    printf "Done.\n"
fi

