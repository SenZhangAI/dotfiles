#!/usr/bin/env bash
# THIS IS CUSTOM CONFIG


# Setting global user.name user.email for git.
# If git global user.name or user.email already exists, it will just ignore.
GLOBAL_GIT_USER_NAME="Sen Zhang"
GLOBAL_GIT_USER_EMAIL="szhang.hust@gmail.com"

# Help cache user name and password for git, so we won't need to type them again,
# 'store' will cache user name and password permanently.
# 'cache --timeout 7200' will cache user name and password in 7200 seconds(2 hours).
GLOGAL_GIT_CREDENTIAL_CACHE="store"

SSH_KEY_EMAIL=$GIT_USER_EMAIL
