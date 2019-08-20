#!/usr/bin/env bash

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../config.sh
source $base_dir/../utils/smart_install.sh
source $base_dir/../utils/print.sh

# help detecting bug, if using unset variables
set -u

if command_not_installed ssh; then
    smart_install openssh
fi

printf "%-48s" "Check if ssh configured..."
search=`cat $HOME/.ssh/id_rsa.pub | grep "$SSH_KEY_EMAIL"`

if [ -z "$search" ]; then
    printf "$(RED "Not Configured")\n"

    printf "%-48s" "[Config] add ssh key..."
    ssh-keygen -t rsa -b 4096 -C "$SSH_KEY_EMAIL"
    eval $(ssh-agent -s)
    ssh-add ~/.ssh/id_rsa
    printf "$(GREEN "Done")\n"
else
    printf "$(GREEN "Configured")\n"
fi

_copy=""
if command_installed pbcopy; then
    _copy="pbcopy "
elif command_installed copy; then
    # TODO unsupported for other copy cmd, add some in the future.
    _copy="copy "
fi

if [ ! -z $_copy ]; then
    printf "%-48s" "[Copy] ssh pub key..."
    eval "$_copy < ~/.ssh/id_rsa.pub"
    printf "$(GREEN "Done")\n"
fi
unset _copy

set +u
