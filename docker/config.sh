#!/usr/bin/env bash

# https://docs.docker.com/config/daemon/

set -e

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/smart_install.sh

case $OSTYPE in
    cygwin*)
        ;;
    linux*)
        cp -i $base_dir/daemon.json /etc/docker/
        sudo systemctl daemon-reload
        sudo systemctl restart docker
        ;;
    darwin*)
        ;;
esac

# vim:sw=4
