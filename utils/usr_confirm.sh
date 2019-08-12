#!/usr/bin/env bash

#include once
if [ -z "$_USR_CONFIRM_LOADED" ]; then
    _USR_CONFIRM_LOADED=1
else
    return 0
fi

usr_confirm() {
    printf "\033[33m$1\033[0m [y/N] "
    read ans
    case $ans in
        Y | y)
            return 0;;
        *)
            return 1;;
    esac
}

