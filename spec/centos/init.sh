
#!/usr/bin/env bash

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../../utils/platform.sh
source $base_dir/../../utils/smart_install.sh
source $base_dir/../../utils/usr_confirm.sh

if usr_confirm "would you like to add IUS repository?"; then
    sudo yum install https://$(rpm -E '%{?centos:centos}%{!?centos:rhel}%{rhel}').iuscommunity.org/ius-release.rpm
fi

