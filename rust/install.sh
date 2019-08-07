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
