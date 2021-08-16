#!/usr/bin/env bash

set -e

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/smart_install.sh

if command_not_installed zsh; then
    smart_install zsh
fi

config_zsh() {
    printf "%-48s" "Check if zsh configured..."

    if [ -d "$HOME/.oh-my-zsh" ]; then
        printf "$(GREEN "Configured")\n"
    else
        printf "$(RED "Not Configured")\n"
        printf "%-48s"  "[Config] Configured zsh...\n"
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        wait
        printf "$(GREEN "Done")\n"
    fi
}

custom_config_oh_my_zsh() {
    zsh_conf_dir=$HOME/oh-my-zsh-sen
    if [ -d $zsh_conf_dir ]; then
        cd $zsh_conf_dir
        git pull
    else
        git clone https://github.com/SenZhangAI/oh-my-zsh-sen $zsh_conf_dir
        cd $zsh_conf_dir
    fi
    unset zsh_conf_dir
    ./install.sh &
    wait
}

config_zsh
custom_config_oh_my_zsh

# vim: sw=4
