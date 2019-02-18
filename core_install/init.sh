#!/usr/bin/env bash

# do the basic installing or setting

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/platform.sh

case $SYSTEM in
    Cygwin)
        ;;
    macOS)
        #install brew
        if ! command -v brew >/dev/null 2>&1; then
            printf "Brew is not installed! Install brew...\n"
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        fi

        echo "Change mirrors for Homebrew"
        #see https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/
        cd "$(brew --repo)"
        git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

        cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
        git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git

        export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
        # Make sure we’re using the latest Homebrew.
        echo "brew update"
        brew update

        # Upgrade any already-installed formulae.
        echo "brew upgrade"
        brew upgrade
        ;;

    msys2)
        cp $base_dir/ideavimrc $HOME/.ideavimrc
        ;;
    *)
        echo "Error: system is not supported yet :("
        exit -1
        ;;
esac

