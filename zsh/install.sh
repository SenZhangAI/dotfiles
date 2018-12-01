#!/usr/bin/env bash

echo -e "[Check] \033[32mzsh\033[0m already configured?"

if [ -d "$ZSH" ]; then
    echo -e "Installed.\n"
else
    echo -e "Not Installed.\n"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -f "/etc/passwd" ]; then
    mkpasswd > /etc/passwd
fi

# vim:st=4:sw=4
