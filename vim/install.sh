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
    if command_not_installed vim && command_not_installed nvim; then
        case $SYSTEM in
            Cygwin)
                ;;
            CentOS)
                #install_vim8_from_src
                sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm || echo "ok"
                sudo yum install -y python-devel python36 python36-devel neovim python3-neovim

                curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
                sudo yum install -y nodejs
                curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
                sudo yum install -y yarn

                npm install -g neovim
                yum install -y python36-setuptools
                easy_install-3.6 pip
                pip3 install neovim

                sudo yum install -y epel-release
                sudo yum install -y snapd
                sudo systemctl enable --now snapd.socket
                sudo ln -s /var/lib/snapd/snap /snap
                ## Need reboot here when using real machine
                sudo snap install clangd --classic
                ;;
            *)
                ;;
        esac
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
