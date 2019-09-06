#!/usr/bin/env sh

shopt -s nocasematch

#include once
if [ -z "$_PLATFORM_LOADED" ]; then
    _PLATFORM_LOADED=1
else
    return 0
fi

system_is() {
    if [[ $(uname -a 2>/dev/null) =~ $1 ]]; then
        return 0
    else
        return 1
    fi
}

SYSTEM='UNKNOWN'
if system_is Cygwin; then SYSTEM='Cygwin'; fi
if system_is MSYS; then SYSTEM='Msys2'; fi
if system_is Darwin; then SYSTEM='macOS'; fi
if system_is Ubuntu; then SYSTEM='Ubuntu'; fi
if system_is Centos; then SYSTEM='Centos'; fi
if system_is Arch; then SYSTEM='Arch'; fi

# some system can not get by uname -a, need more information
if [[ $SYSTEM == 'UNKNOWN' ]]; then
    if [ -f "/etc/redhat-release" ]; then
        test=$(cat /etc/redhat-release)
        if [[ $test =~ Centos ]]; then
            SYSTEM='Centos'
        fi
    fi
    if [[ -d "/etc/pacman.d" && ! -f "/etc/pacman.d/mirrorlist.mingw32" ]]; then
        SYSTEM='Arch'
    fi
fi

if [[ $SYSTEM == 'UNKNOWN' ]]; then
    echo "Error: system type still Unknown: $(uname)"
else
    echo "Detected System: $SYSTEM"
fi

shopt -u nocasematch
