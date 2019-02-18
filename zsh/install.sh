#!/usr/bin/env bash

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/smart_install.sh

if command_not_installed zsh; then
    smart_install zsh
fi

echo -e "[Check] \033[32mzsh\033[0m configured by oh-my-zsh?"

if [ -d "$HOME/.oh-my-zsh" ]; then
    echo -e "Configured.\n"
else
    echo -e "Not Configured.\n"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -f "/etc/passwd" ]; then
    mkpasswd > /etc/passwd
fi

# vim:st=4:sw=4
