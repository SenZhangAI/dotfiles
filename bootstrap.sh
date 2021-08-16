#!/usr/bin/env bash

set -e
shopt -s nocasematch

bakfile() {
    if [ ! -f $1.bak ]; then
        echo "backup file $1 ..."
        cp $1 $1.bak
    fi
}

system_is() {
    if [[ $(uname -a 2>/dev/null) =~ $1 ]]; then
        return 0
    else
        return 1
    fi
}

GREEN() {
    printf "\033[32m$1\033[0m"
}

RED() {
    printf "\033[31m$1\033[0m"
}

command_installed() {
    printf "%-48s" "Check command $1..."
    command -v $1 >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        printf "Not Installed\n"
        return 1
    else
        printf "Installed\n"
        return 0
    fi
}

command_not_installed() {
    printf "%-48s" "Check command $1..."
    command -v $1 >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        printf "Not Installed\n"
        return 0
    else
        printf "Installed\n"
        return 1
    fi
}

must_install() {
    if command_not_installed $1; then
        printf "\033[33m$1\033[0m need to be installed first!\n"
        exit 233
    fi
}

init_install_config() {
    if system_is Cygwin; then
        must_install wget

    elif system_is Ubuntu; then
        if command_not_installed git; then
            apt-get -y install git
        fi

    elif system_is CentOS; then
        if command_not_installed git; then
            yum -y install git
        fi

    elif system_is Darwin;then
        if command_not_installed brew; then
            printf "%-48s" "[Install] install brew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            printf "$(GREEN "Done")\n"
        fi
        if command_not_installed git; then
            brew install git
        fi
        printf "%-48s" "[Config] change mirrors for Homebrew..."
        #see https://mirrors.ustc.edu.cn
        cd "$(brew --repo)" && git remote set-url origin https://mirrors.ustc.edu.cn/brew.git
        cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core" && git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git
        cd "$(brew --repo)/Library/Taps/homebrew/homebrew-cask" && git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git
        export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
        #export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-cask.git
        printf "$(GREEN "Done")\n"
        if [ -f $HOME/.local/dotfiles/spec/macOS/.brew-update ]; then
            export HOMEBREW_NO_AUTO_UPDATE=true
        else
            brew tap homebrew/cask
            brew update
            brew upgrade
        fi

    elif system_is MSYS; then
        bakfile /etc/pacman.d/mirrorlist.mingw32
        bakfile /etc/pacman.d/mirrorlist.mingw64
        bakfile /etc/pacman.d/mirrorlist.msys
        echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/i686' > /etc/pacman.d/mirrorlist.mingw32
        echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/x86_64' > /etc/pacman.d/mirrorlist.mingw64
        echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/msys/$arch' > /etc/pacman.d/mirrorlist.msys
        pacman -Syu --noconfirm
        if command_not_installed git; then
            pacman -Sy --noconfirm git
        fi

    elif system_is Arch; then
        cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
        echo 'Server = http://mirrors.163.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
        echo 'Server = http://mirrors.cqu.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
        echo 'Server = https://mirrors.cqu.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
        echo 'Server = http://mirror.lzu.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
        echo 'Server = http://mirrors.neusoft.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
        echo 'Server = https://mirrors.neusoft.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
        echo 'Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
        echo 'Server = http://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
        echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
        echo 'Server = http://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
        echo 'Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
        echo 'Server = https://mirrors.xjtu.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
        echo 'Server = http://mirrors.zju.edu.cn/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
        pacman -Syyu --noconfirm
        pacman -S pacman --noconfirm
        pacman-db-upgrade
        pacman -Sy --noconfirm git
    fi
}
init_install_config

# check if git installed
must_install git

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

# solve `go get` problem
install_git_wapper() {
    if command_installed go; then
        # go is excutable
        go build -o ./git.exe ./git/gitwapper/git.go
        # MAKE SURE $BIN is in $PATH and is the first directory that can find command git
        mv git.exe $BIN/git
    fi
}
install_git_wapper

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
    if [[ "$OSTYPE" =~ "darwin" ]]; then
        sed -i '' "\:$ETC/bashrc.sh:d" $HOME/.bashrc
    else
        sed -i "\:$ETC/bashrc.sh:d" $HOME/.bashrc
    fi
    echo "source $ETC/bashrc.sh" >> $HOME/.bashrc
fi

shopt -u nocasematch

printf "$(GREEN "Install Successfully")\n"

# vim: sw=4:ts=4
