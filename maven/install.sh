#!/usr/bin/env bash

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

case $SYSTEM in
    CentOS)
        if command_installed mvn; then
            wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
            yum -y install apache-maven
        fi
        ;;
    macOS)
        cp $base_dir/settings.xml $HOME/.m2/
        ;;
    *)
        echo "not supported"
        ;;
esac

