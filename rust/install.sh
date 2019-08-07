#!/usr/bin/env bash

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/platform.sh
source $base_dir/../utils/smart_install.sh
source $base_dir/../utils/usr_confirm.sh

if command_not_installed rustc; then
    if command_installed brew; then
        brew install rust
    else
        curl https://sh.rustup.rs -sSf | sh
    fi
fi

if command_installed vim; then
    printf "Install coc rust plugin for vim... "
    vim -c "CocInstall -sync coc-rls | qall"
    printf "\t\t\tDone.\n"
fi

rustup component add rls rust-analysis rust-src
