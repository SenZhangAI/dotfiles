#!/usr/bin/env bash

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/platform.sh
source $base_dir/../utils/smart_install.sh
source $base_dir/../utils/usr_confirm.sh
source $base_dir/../utils/print.sh

auto_install git

printf "%-48s" "[Check] git global user.email configured?..."
search=`git config --global user.email`
if [ -z "$search" ]; then
    printf "$(RED "Not Configured")\n"
    echo "[Config] user.email..."
    git config --global user.email "szhang.hust@gmail.com"
    printf "$(GREEN "Done")\n"
else
    printf "$(GREEN "Configured")\n"
fi

printf "%-48s" "[Check] git global user.name configured?..."
search=`git config --global user.name`
if [ -z "$search" ]; then
    printf "$(RED "Not Configured")\n"
    echo "[Config] user.name..."
    git config --global user.name "Sen Zhang"
    printf "$(GREEN "Done")\n"
else
    printf "$(GREEN "Configured")\n"
fi


printf "%-48s" "[Config] save username and password..."
# store username and password so I won't need to type username and password again.
#git config --global credential.helper 'cache --timeout 7200'
git config --global credential.helper store
printf "$(GREEN "Done")\n"

printf "%-48s" "[Config] enable ui color..."
git config --global color.ui true
printf "$(GREEN "Done")\n"

printf "%-48s" "[Config] enable zh-cn character set..."
git config --global core.quotepath false
printf "$(GREEN "Done")\n"

# vim:sw=4
