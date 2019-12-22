#!/usr/bin/env bash

case $SYSTEM in
    CentOS)
        sudo yum-config-manager \
            --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
        sudo yum install ripgrep
        ;;
    *)
        echo "TODO: not supported yet"
        exit -1
        ;;
esac

# vim:sw=4
