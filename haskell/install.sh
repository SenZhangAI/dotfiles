#!/usr/bin/env bash

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/smart_install.sh
source $base_dir/../utils/usr_confirm.sh

if command_not_installed perl; then
    smart_install perl
fi

install_haskell() {
    if command_not_installed stack; then
        curl -sSL https://get.haskellstack.org/ | sh
    fi

    if command_not_installed hindent; then
        stack install hindent
    fi
}

## check if stack has configured mirrors to speed up
stack_need_conf_mirrors() {
    mirror_url=$(perl -ne 'print if /^\s*download-prefix:\s*.*tsinghua.*/' $1)

    if [[ -n $mirror_url ]]; then
        unset mirror_url
        return 1
    else
        unset mirror_url
        return 0
    fi
}

config_haskell_stack() {
    conf=$HOME/.stack/config.yaml
    if [ -f $conf ]; then
        if stack_need_conf_mirrors $conf; then
            echo "Configuring stack ..."
            echo '
            ###ADD THIS IF YOU LIVE IN CHINA
            #### @see https://docs.haskellstack.org/en/stable/install_and_upgrade/#china-based-users
            setup-info: "http://mirrors.tuna.tsinghua.edu.cn/stackage/stack-setup.yaml"
            urls:
            latest-snapshot: http://mirrors.tuna.tsinghua.edu.cn/stackage/snapshots.json
            lts-build-plans: http://mirrors.tuna.tsinghua.edu.cn/stackage/lts-haskell/
            nightly-build-plans: http://mirrors.tuna.tsinghua.edu.cn/stackage/stackage-nightly/
            package-indices:
            - name: Tsinghua
            download-prefix: http://mirrors.tuna.tsinghua.edu.cn/hackage/package/
            http: http://mirrors.tuna.tsinghua.edu.cn/hackage/00-index.tar.gz
            ' >> /dev/null # $conf
        fi
    fi
    unset conf
}

install_haskell
config_haskell_stack
