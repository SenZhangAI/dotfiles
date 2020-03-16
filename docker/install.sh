#!/usr/bin/env bash

# https://docs.docker.com/config/daemon/

set -e

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/smart_install.sh

case $SYSTEM in
    Cygwin)
        ;;
    CentOS)
        sudo yum remove docker \
            docker-client \
            docker-client-latest \
            docker-common \
            docker-latest \
            docker-latest-logrotate \
            docker-logrotate \
            docker-engine

        sudo yum install -y yum-utils \
            device-mapper-persistent-data \
            lvm2
        sudo yum-config-manager \
            --add-repo \
        http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

        sudo yum install -y docker-ce docker-ce-cli containerd.io

        sudo systemctl start docker

        sudo yum -y install epel-release python-pip
        pip install --upgrade pip
        pip install docker-compose
        docker-compose -version
        ;;
    *)
        ;;
esac

# vim:sw=4
