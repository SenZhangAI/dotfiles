#!/usr/bin/env bash

#include once
if [ -z "$_PLATFORM_LOADED" ]; then
    _PLATFORM_LOADED=1
else
    return
fi

system_is() {
    test=$(uname -a 2>/dev/null | grep -i $1)
    if [ -z "$test" ]; then
        return 1
    else
        return 0
    fi
}

SYSTEM='UNKNOWN'

if system_is Cygwin; then SYSTEM='Cygwin'; fi
if system_is MSYS; then SYSTEM='Msys2'; fi
if system_is Darwin; then SYSTEM='macOS'; fi
if system_is Ubuntu; then SYSTEM='Ubuntu'; fi
if system_is Centos; then SYSTEM='Centos'; fi
if system_is Arch; then SYSTEM='Arch'; fi

if [ $SYSTEM == 'UNKNOWN' ]; then
    echo "Error: system type unknown: $(uname)"
fi

echo "Detected System: $SYSTEM"

