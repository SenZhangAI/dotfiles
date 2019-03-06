#!/usr/bin/env bash

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/platform.sh
source $base_dir/../utils/smart_install.sh

install_tmux_from_source() {
    echo "Installing tmux from source..."
    smart_install ncursors libevent
    cd $base_dir
    git clone --depth=1 https://github.com/tmux/tmux.git
    cd tmux
    sh autogen.sh
    ./configure && make
    cp ./tmux/tmux $HOME/bin
    rm -rf tmux
    echo "Install tmux done."
}

check_and_kill_running_tmux() {
    _tmux_running_pid=$(pidof tmux)
    if [! -z $_tmux_running_pid ]; then
        read -p "old version tmux is running, would you like to kill?[y/n]" ans
        if [ $ans == "y" ]; then
            pkill tmux
        fi
    fi
    unset _tmux_running_pid
}

case $SYSTEM in
    Centos)
        if command_installed tmux; then
            _tmux_version=$(tmux -V)
            printf "Check [tmux] version...%-34s$_tmux_version\n"
            if [[ $_tmux_version =~ "1.*" ]]; then
                echo "tmux version 1.X is old, try to uninstall it..."
                yum remove tmux
                check_and_kill_running_tmux
                install_tmux_from_source
            fi
            unset _tmux_version
        else
            echo "tmux is not installed yet."
            install_tmux_from_source
        fi
        ;;
    *)
        ;;
esac

printf "Check if [tmux] configured..."

if [ -d "$HOME/.tmux" ]; then
    printf "%-27s Yes.\n"
else
    printf "%-27s No.\n"
    echo -e "Config tmux..."
    cd $HOME
    git clone --depth=1 https://github.com/gpakosz/.tmux.git
    ln -s -f .tmux/.tmux.conf
    cp .tmux/.tmux.conf.local .
    printf "Config tmux Done.\n"
fi

