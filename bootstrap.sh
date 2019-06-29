#!/usr/bin/env bash

set -e

bakfile() {
    if [ ! -f $1.bak ]; then
        echo "backup file $1 ..."
        cp $1 $1.bak
    fi
}

system_is() {
    test=$(uname -a 2>/dev/null | grep -i $1)
    if [ -z "$test" ]; then
        return 1
    else
        return 0
    fi
}

init_install_config() {
    case $OSTYPE in
        cygwin*)
            if [[ -z $(which git 2>/dev/null) ]]; then
                printf "\033[32mgit\033[0m need to be installed first!\n"
                exit 233
            fi
            if [[ -z $(which wget 2>/dev/null) ]]; then
                printf "\033[32mwget\033[0m need to be installed first!\n"
                exit 233
            fi
            ;;
        darwin*)
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

            if [ -f $HOME/.local/dotfiles/spec/macOS/.brew-update ]; then
                export HOMEBREW_NO_AUTO_UPDATE=true
            else
                brew tap homebrew/cask
                # Make sure we’re using the latest Homebrew.
                echo "brew update"
                brew update

                # Upgrade any already-installed formulae.
                echo "brew upgrade"
                brew upgrade
                brew install git
            fi

            ;;
        msys*)
            bakfile /etc/pacman.d/mirrorlist.mingw32
            bakfile /etc/pacman.d/mirrorlist.mingw64
            bakfile /etc/pacman.d/mirrorlist.msys
            echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/i686' > /etc/pacman.d/mirrorlist.mingw32
            echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/x86_64' > /etc/pacman.d/mirrorlist.mingw64
            echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/msys/$arch' > /etc/pacman.d/mirrorlist.msys

            pacman -Syu --noconfirm
            if [ -z $(which git 2>/dev/null) ]; then
                pacman -Sy --noconfirm git
            fi
            ;;
        *)
            ;;
    esac
}

init_install_config

ETC=$HOME/.local/etc
BIN=$HOME/.local/bin
mkdir -p $ETC
mkdir -p $BIN

# git clone respository
cd $HOME/.local/
if [ -d dotfiles ]; then
    cd dotfiles
    git pull
else
    git clone https://github.com/SenZhangAI/dotfiles
    cd dotfiles
fi

cp -rf etc/* $ETC/
cp -rf bin/* $BIN/
cp bootstrap.sh $BIN/

_set_go_env_for_cygwin() {
    batfile=cygwin_set_go_env.bat
    GOBASEPATH="$HOME/GoWorkSpace"
    GOPATH_WIN=`cygpath -a -w $GOBASEPATH`
    GOBIN_WIN=`cygpath -a -w $GOBASEPATH/bin`

    echo "@ECHO OFF" > $batfile
    echo "ECHO \"Set Environment for go...\"" >> $batfile
    echo "SETX GOPATH $GOPATH_WIN" >> $batfile
    echo "SETX GOBIN $GOBIN_WIN" >> $batfile
    echo "ECHO \"Done. It will auto delete this tmp file.\"" >> $batfile
    echo "PAUSE" >> $batfile
    echo "ATTRIB -h -s- r -a %0" >> $batfile
    echo "DEL %0" >> $batfile
    printf "For setting golang env, plese run \e[32m$batfile\e[0m by Administrator Role.\n"
    explorer . &
}

platform_spec_config() {
    case $OSTYPE in
        cygwin*)
            cp -rf spec/cygwin/bin/* $BIN/
            _set_go_env_for_cygwin

            if [[ ! -z $(which go 2>/dev/null) ]]; then
                # go is excutable
                echo go build -o $BIN/git.exe ./spec/cygwin/git.go
                go build -o git.exe ./spec/cygwin/git.go
                mv git.exe $BIN/
            fi
            ;;
        darwin*)
            cp -rf spec/macOS/bin/* $BIN/
            ;;
        msys*)
            ;;
        *)
            ;;
    esac
}

platform_spec_config

# source init.sh, move to the end line

if [ -f $HOME/.bashrc ]; then
    sed -i '' "\:$ETC/bashrc.sh:d" $HOME/.bashrc
    echo "source $ETC/bashrc.sh" >> $HOME/.bashrc
fi

echo "Install Successfully."

# vim: sw=4:ts=4
