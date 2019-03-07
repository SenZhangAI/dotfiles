#!/usr/bin/env bash

init_install_config() {
    case $OSTYPE in
        cygwin*)
            if [ -z $(which git 2>/dev/null) ]; then
                printf "\033[32mgit\033[0m need to be installed first!\n"
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
            # Make sure we’re using the latest Homebrew.
            echo "brew update"
            brew update

            # Upgrade any already-installed formulae.
            echo "brew upgrade"
            brew upgrade

            brew install git
            ;;
        msys*)
            cp /etc/pacman.d/mirrorlist.mingw32 /etc/pacman.d/mirrorlist.mingw32.bak
            cp /etc/pacman.d/mirrorlist.mingw64 /etc/pacman.d/mirrorlist.mingw64.bak
            cp /etc/pacman.d/mirrorlist.msys /etc/pacman.d/mirrorlist.msys.bak
            echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/i686' > /etc/pacman.d/mirrorlist.mingw32
            echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/x86_64' > /etc/pacman.d/mirrorlist.mingw64
            echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/msys/$arch' > /etc/pacman.d/mirrorlist.msys

            pacman -Syu
            if [ -z $(which git 2>/dev/null) ]; then
                pacman -Sy git
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
#cp all files in dotfiles/bin to $BIN
for f in `find ./bin/ -type f`; do
    cp $f $BIN/
done

system_is() {
    test=$(uname -a 2>/dev/null | grep -i $1)
    if [ -z "$test" ]; then
        return 1
    else
        return 0
    fi
}

if system_is cygwin;then
    cp bin/cygwin/* bin/
fi

cp bootstrap.sh $BIN/

# source init.sh, move to the end line
sed -i "\:$ETC/bashrc.sh:d" $HOME/.bashrc
echo "source $ETC/bashrc.sh" >> $HOME/.bashrc

echo "Install Successfully."

