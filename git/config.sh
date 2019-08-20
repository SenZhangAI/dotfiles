#!/usr/bin/env bash

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../config.sh
source $base_dir/../utils/platform.sh
source $base_dir/../utils/smart_install.sh
source $base_dir/../utils/usr_confirm.sh
source $base_dir/../utils/print.sh

# help detecting bug, if using unset variables
set -u

auto_install git

printf "%-48s" "[Check] git global user.email configured?..."
search=`git config --global user.email`
if [ -z "$search" ]; then
    printf "$(RED "Not Configured")\n"
    printf "%-48s" "[Config] user.email..."
    git config --global user.email "$GLOBAL_GIT_USER_EMAIL"
    printf "$(GREEN "Done")\n"
else
    printf "$(GREEN "Configured")\n"
fi

printf "%-48s" "[Check] git global user.name configured?..."
search=`git config --global user.name`
if [ -z "$search" ]; then
    printf "$(RED "Not Configured")\n"
    printf "%-48s" "[Config] user.name..."
    git config --global user.name "$GLOBAL_GIT_USER_NAME"
    printf "$(GREEN "Done")\n"
else
    printf "$(GREEN "Configured")\n"
fi


printf "%-48s" "[Config] save username and password..."
# store username and password so I won't need to type username and password again.
#git config --global credential.helper 'cache --timeout 7200'
git config --global credential.helper "$GLOGAL_GIT_CREDENTIAL_CACHE"
printf "$(GREEN "Done")\n"

printf "%-48s" "[Config] enable ui color..."
git config --global color.ui true
printf "$(GREEN "Done")\n"

printf "%-48s" "[Config] enable zh-cn character set..."
git config --global core.quotepath false
printf "$(GREEN "Done")\n"

set +u

# vim:sw=4
