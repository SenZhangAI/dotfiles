#!/usr/bin/env bash

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/smart_install.sh

if command_not_installed zsh; then
    smart_install zsh
fi

config_zsh() {
    printf "[Check] \033[32mzsh\033[0m configured?"

    if [ -d "$HOME/.oh-my-zsh" ]; then
        printf "%-20s Yes.\n"
    else
        printf "%-20s No.\n"
        printf "Configured zsh...\n"
        {
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        } &
    wait
    fi
}

set_zsh_default_shell() {
    echo "default shell is $SHELL"
    if [[ $SHELL =~ zsh ]]; then
        return
    fi
    echo "Change defalt shell to zsh..."

    if [ ! -f "/etc/passwd" ]; then
        mkpasswd > /etc/passwd
    fi

    #TODO
}

config_zsh

set_zsh_default_shell

# vim:st=4:sw=4
