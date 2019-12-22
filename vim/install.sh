#!/usr/bin/env bash

set -e

echo "[Config] .ideavimrc"

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $base_dir/../utils/smart_install.sh

case $OSTYPE in
    cygwin*)
        cp $base_dir/ideavimrc $(cygpath -w $USERPROFILE/.ideavimrc)
        ;;
    msys*)
        cp $base_dir/ideavimrc $USERPROFILE/.ideavimrc
        ;;
    darwin*)
        cp $base_dir/ideavimrc $HOME/.ideavimrc
        ;;
    linux*)
        cp $base_dir/ideavimrc $HOME/.ideavimrc
        ;;
esac

install_vim8_from_src() {
    yum install -y gcc gcc-c++ ruby ruby-devel lua lua-devel  \
        ctags git python python-devel \
        tcl-devel ncurses-devel \
        perl perl-devel perl-ExtUtils-ParseXS \
        perl-ExtUtils-CBuilder \
        perl-ExtUtils-Embed


    _old_dir=$pwd
    mkdir -p /tmp
    cd /tmp
    git clone --depth=1 https://github.com/vim/vim
    cd vim

    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-rubyinterp=yes \
        --enable-pythoninterp=yes \
        --with-python-config-dir=/usr/lib64/python2.7/config \
        --enable-perlinterp=yes \
        --enable-luainterp=yes \
        --enable-cscope \
        --prefix=/usr/local

    make VIMRUNTIMEDIR=/usr/local/share/vim/vim81

    make install
}

install_vim() {
    if command_not_installed vim; then
        case $SYSTEM in
            Cygwin)
                ;;
            CentOS)
                #install_vim8_from_src

                ;;
            *)
                ;;
        esac
    fi

    if command_not_installed clang; then
        smart_install clang
    fi

    if command_not_installed gcc; then
        smart_install gcc
    fi

    if command_installed pip2; then
        pip2 install neovim
    fi

    if command_installed pip3; then
        pip3 install neovim
    fi

    if command_not_installed node; then
        curl -sL install-node.now.sh/lts | bash
    fi
}

config_vim() {
    vim_dir=$HOME/.vim/vim
    if [ -d $vim_dir ]; then
        cd $vim_dir
        git pull
    else
        mkdir -p $HOME/.vim
        cd $HOME/.vim && git clone https://github.com/SenZhangAI/vim
        cd $vim_dir
    fi
    unset vim_dir

    ./install.sh &
    wait
    return 0
}

install_vim
config_vim

# vim:sw=4
