#!/usr/bin/env bash

set -e
base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/smart_install.sh
source $base_dir/../utils/usr_confirm.sh

auto_install perl

## check if stack has configured mirrors to speed up
stack_need_conf_mirrors() {
    if [ ! -f $1 ]; then
        return 0
    fi

    mirror_url=$(perl -ne 'print if /^\s*download-prefix:\s*.*tsinghua.*/' $1)

    if [[ -n $mirror_url ]]; then
        unset mirror_url
        return 1
    else
        unset mirror_url
        return 0
    fi
}

backup_file() {
    if [ -L $1 ] || [ -f $1 ]; then
        echo "There's a original file [$1] exist."
        read -p "Would you like to backup it first? [y/N] " ans

        if [ "$ans" == "y" ]; then
            echo "backup your original $1 to $1-$(date +%Y%m%d).bak"
            cp $1 "$1-$(date +%Y%m%d).bak"
        fi

        rm -f $1
    fi
    return 0;
}

config_haskell_stack() {
    mkdir -p $HOME/.stack

    conf=$HOME/.stack/config.yaml
    echo "Configuring stack ..."
    backup_file $conf
    cat $base_dir/stack_config.yaml > $conf
    unset conf
}
config_haskell_stack

install_haskell() {
    if command_not_installed stack; then
        curl -sSL https://get.haskellstack.org/ | sh
        stack setup
    elif usr_confirm "stack has already installed, would you like force reinstall?"; then
        curl -sSL https://get.haskellstack.org/ | sh -s - -f
        stack setup
    fi
}
install_haskell

install_nix() {
    if command_not_installed nix; then
        #curl https://nixos.org/nix/install | sh
        sh <(curl https://mirrors.tuna.tsinghua.edu.cn/nix/latest/install) --no-daemon &
        wait
    fi

    case $SYSTEM in
        Cygwin*)
            ;;
        Msys2*)
            ;;
        Ubuntu*)
            ;;
        CentOS*)
            ;;
        macOS*)
            . $HOME/.nix-profile/etc/profile.d/nix.sh
            ;;
    esac
}

if command_not_installed runghc; then
    stack install runghc
fi

if command_not_installed stylish-haskell; then
    stack install stylish-haskell
fi

if command_not_installed cabal; then
    stack install cabal-install
fi

install_nix

if command_not_installed hie-wapper; then
    if usr_confirm "Do you want to install \e[32mH\e[0maskell \e[32mI\e[0mDE \e[32mE\e[0mngine"; then
        nix-env -iA hies -f https://github.com/domenkozar/hie-nix/tarball/master
    fi
fi

set +e
