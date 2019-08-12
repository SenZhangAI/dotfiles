#!/usr/bin/env bash

#include once
if [ -z "$_PRINT_LOADED" ]; then
    _PRINT_LOADED=1
else
    return 0
fi

GREEN() {
    printf "\033[32m$1\033[0m"
}

RED() {
    printf "\033[31m$1\033[0m"
}

