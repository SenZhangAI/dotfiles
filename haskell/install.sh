#!/usr/bin/env bash

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/smart_install.sh
source $base_dir/../utils/usr_confirm.sh

if command_not_installed perl; then
    smart_install perl
fi

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

config_haskell_stack() {
    mkdir -p $HOME/.stack

    conf=$HOME/.stack/config.yaml
    if stack_need_conf_mirrors $conf; then
        echo "Configuring stack ..."
        cat $base_dir/stack_config.yaml > $conf
    fi
    unset conf
}

install_haskell() {
    if command_not_installed stack; then
        curl -sSL https://get.haskellstack.org/ | sh
        config_haskell_stack
        stack setup
    elif usr_confirm "stack has already installed, would you like force reinstall?"; then
        curl -sSL https://get.haskellstack.org/ | sh -s - -f
        config_haskell_stack
        stack setup
    fi
}

install_nix() {
    if command_not_installed nix; then
        #curl https://nixos.org/nix/install | sh
        sh <(curl https://mirrors.tuna.tsinghua.edu.cn/nix/latest/install) --no-daemon &
        wait
    fi
}

install_haskell

if command_not_installed runghc; then
    stack install runghc
fi

if command_not_installed hindent; then
    # > 1G memory
    stack install hindent
    #stack build --copy-compiler-tool hindent
fi

if command_not_installed cabal; then
    stack install cabal-install
fi

install_nix
