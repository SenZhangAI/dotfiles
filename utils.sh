#!/usr/bin/env bash

command_not_installed() {
  echo "Check if [$1] installed..."
  found=$(which $1 2>/dev/null)
  if [ -z "$found" ]; then
    echo -e "\t------- No"
    return 0
  else
    echo -e "\t------- Yes"
    return 1
  fi
}
