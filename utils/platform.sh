#!/usr/bin/env sh

shopt -s nocasematch

#include once
if [ -z "$_PLATFORM_LOADED" ]; then
    _PLATFORM_LOADED=1
else
    return 0
fi

util_base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $util_base_dir/../config.sh

system_is() {
    if [[ $(uname -a 2>/dev/null) =~ $1 ]]; then
        return 0
    else
        return 1
    fi
}

# try to detect system automatically
auto_detect_sys() {
    _SYSTEM='UNKNOWN'
    if system_is Cygwin; then _SYSTEM='Cygwin'; fi
    if system_is MSYS; then _SYSTEM='Msys2'; fi
    if system_is Darwin; then _SYSTEM='macOS'; fi
    if system_is Ubuntu; then _SYSTEM='Ubuntu'; fi
    if system_is CentOS; then _SYSTEM='CentOS'; fi
    if system_is Arch; then _SYSTEM='Arch'; fi

    if [[ $_SYSTEM == 'UNKNOWN' ]]; then
        if [ -f "/etc/redhat-release" ]; then
            test=$(cat /etc/redhat-release)
            if [[ $test =~ CentOS ]]; then
                _SYSTEM='CentOS'
            fi
        fi
        if [[ -d "/etc/pacman.d" && ! -f "/etc/pacman.d/mirrorlist.mingw32" ]]; then
            _SYSTEM='Arch'
        fi
    fi

    if [[ $_SYSTEM == 'UNKNOWN' ]]; then
        echo "Detect System failed: system type still Unknown."
        echo "  uname: $(uname -a)"
        exit -1
    else
        SYSTEM=$_SYSTEM
        echo "Detected System: $SYSTEM"
    fi
}

if [[ $SYSTEM == 'AutoDetect' ]]; then
    auto_detect_sys
fi

shopt -u nocasematch
