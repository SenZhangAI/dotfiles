#!/usr/bin/env bash

# using proxy
#export ALL_PROXY=http://127.0.0.1:1087

echo "Change mirrors for Homebrew"
#see https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/
cd "$(brew --repo)"
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git

export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles

# disable homebrew update, it's too slow!
export HOMEBREW_NO_AUTO_UPDATE=true

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install `wget` with IRI support.
brew install wget

# Install more recent versions of some macOS tools.
brew unlink vim # unlink vim before installing macvim
brew install macvim
brew install neovim
brew install grep
brew install openssh

brew install cmake
brew install ctags
brew install fzf
$(brew --prefix)/opt/fzf/install
brew install ripgrep
brew install git
brew install perl
brew install tldr
brew install telnet
brew install tmux
brew install tree
brew install xz
brew install clang-format
brew install global # for gtags
brew install aria2

brew cask install iterm2
brew cask install shadowsocksx-ng
brew cask install alfred
brew cask install hammerspoon
brew cask install qq
brew cask install wechat
brew cask install nutstore && open /usr/local/Caskroom/nutstore/latest &
brew cask install iina
brew cask install teamviewer
brew cask install google-chrome
brew cask install thunder

######################## OPTIONAL APPLICATION #########################
#brew cask install flash-player

#brew install gsmartcontrol ## a GUI app show S.M.A.R.T message of disk
#brew install aliwangwang
#brew install node
#brew install yarn

#brew cask install kindle
#brew cask install calibre

#brew install sqlite
#brew install mysqlworkbench
#brew install mycli
#brew cask install sequel-pro ## the newest version is better, see https://sequelpro.com/test-builds

#brew install protobuf
#brew cask install visual-studio-code ## too slow
#brew install go
#brew cask install goland
#brew install ruby
#brew cask install rubymine
#brew cask install clion
#brew cask install pycharm-ce
#brew cask install phpstorm

#brew cask install virtualbox
#brew cask install virtualbox-extension-pack

#brew cask install gitkraken
#brew cask install keycaskr ## a keystroke visualizer
#brew cask install switchhosts

#brew cask install vagrant
#vagrant plugin install vagrant-vbguest

## NTFS Support for MAC
### see https://devstudioonline.com/article/enable-ntfs-file-system-in-mac-os-mojave
#brew cask install osxfuse
#brew install ntfs-3g
#######################################################################

# Remove outdated versions from the cellar.
echo "[Run] brew cleanup"
brew cleanup

