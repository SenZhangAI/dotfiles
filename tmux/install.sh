#!/usr/bin/env bash

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/platform.sh
source $base_dir/../utils/smart_install.sh
source $base_dir/../utils/usr_confirm.sh

_install_tmux_from_source() {
    echo "Installing tmux from source..."
    install_tmux_dir=$HOME/.tmp/tmux
    if [ -d $install_tmux_dir ]; then rm -rf $install_tmux_dir; fi
    mkdir $HOME/.tmp

    git clone --depth=1 https://github.com/tmux/tmux.git $install_tmux_dir
    cd $install_tmux_dir
    sh autogen.sh
    ./configure && make
    mkdir -p $HOME/.local/bin
    cp $install_tmux_dir/tmux $HOME/.local/bin
    rm -rf $HOME/.tmp
    echo "Install tmux done."
}

_check_and_kill_running_tmux() {
    _tmux_running_pid=$(pidof tmux)
    if [ ! -z $_tmux_running_pid ]; then
        if usr_confirm "old version tmux is running, would you like to kill?"; then
            pkill tmux
        fi
    fi
    unset _tmux_running_pid
}

case $SYSTEM in
    CentOS)
        if command_installed tmux; then
            _tmux_version=$(tmux -V)
            printf "%-48s" "Check [tmux] version..."
            printf "$(GREEN $_tmux_version)\n"
            if [[ "$_tmux_version" =~ 1\.[0-9]* ]]; then
                echo "tmux version 1.X is old, try to uninstall it..."
                yum remove -y tmux
                _check_and_kill_running_tmux

                smart_install ncurses ncurses-devel libevent libevent-devel automake byacc
                _install_tmux_from_source
            fi
            unset _tmux_version
        else
            echo "tmux is not installed yet."
            smart_install ncurses ncurses-devel libevent libevent-devel automake byacc
            _install_tmux_from_source
        fi
        ;;
    macOS)
        #makes pbcopy and pbpaste work again within tmux.
        brew install reattach-to-user-namespace
        if command_not_installed tmux; then
            brew install tmux
        fi
        ;;
    *)
        if command_not_installed tmux; then
            smart_install tmux
        fi
        ;;
esac

printf "%-48s" "Configured tmux..."
cp $base_dir/.tmux.conf $HOME
printf "$(GREEN "Done")\n"

# echo -e "Config tmux..."
# cd $HOME
# git clone --depth=1 https://github.com/gpakosz/.tmux.git
# ln -s -f .tmux/.tmux.conf
# cp .tmux/.tmux.conf.local .
# printf "Config tmux Done.\n"
