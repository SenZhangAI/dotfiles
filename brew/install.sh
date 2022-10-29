#!/usr/bin/env bash

# using proxy
#export ALL_PROXY=http://127.0.0.1:1087
export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890

# disable homebrew update, it's too slow!
export HOMEBREW_NO_AUTO_UPDATE=true

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install `wget` with IRI support.
brew install wget

# Install more recent versions of some macOS tools.
brew unlink vim # unlink vim before installing macvim
#brew install macvim
brew install neovim
brew install grep

brew install cmake

# Universal Ctags instead of Exuberant Ctags
#brew install ctags
brew unlink ctags
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

brew install fzf
$(brew --prefix)/opt/fzf/install --all
brew install ripgrep
brew install git
brew install perl
brew install tldr
brew install telnet
brew install tmux
brew install tree
brew install xz
brew install p7zip # extract .7z
brew install unrar
brew install clang-format
brew install global # gtags
brew install aria2
brew install llvm && sudo ln -sfn $(brew --prefix)/opt/llvm/bin/* $HOME/bin  # clangd clang-format
brew install go

#brew install --cask julia
brew install --cask iterm2
#brew install --cask shadowsocksx-ng
#brew install --cask alfred
brew install --cask qq
brew install --cask wechat
brew install --cask nutstore && open $(brew --prefix)/Caskroom/nutstore/latest &
brew install --cask iina
#brew install --cask teamviewer
brew install --cask google-chrome
brew install --cask thunder
brew install --cask snipaste

## NTFS Support for MAC
### see https://devstudioonline.com/article/enable-ntfs-file-system-in-mac-os-mojave
#brew install --cask osxfuse
#brew install ntfs-3g

######################## OPTIONAL APPLICATION #########################
#brew install --cask flash-player
#brew install --cask v2rayu

#brew install gsmartcontrol ## a GUI app show S.M.A.R.T message of disk
#brew install aliwangwang
#brew install node
#brew install yarn
#brew install ghc
#brew install --cask hammerspoon

#brew tap homebrew/cask-versions
#brew install --cask homebrew/cask-versions/adoptopenjdk8

#brew install --cask kindle
#brew install --cask calibre

#brew install sqlite
#brew install mysqlworkbench
#brew install mycli
#brew install --cask sequel-pro ## the newest version is better, see https://sequelpro.com/test-builds

#brew install protobuf
#brew install --cask visual-studio-code ## too slow
#brew install --cask goland
#brew install ruby
#brew install nim
#brew install --cask rubymine
#brew install --cask clion
#brew install --cask pycharm-ce
#brew install --cask phpstorm

#brew install --cask virtualbox
#brew install --cask virtualbox-extension-pack

#brew install --cask gitkraken
#brew install --cask keycaskr ## a keystroke visualizer
#brew install --cask switchhosts

#brew install --cask vagrant
#vagrant plugin install vagrant-vbguest

#######################################################################

# Remove outdated versions from the cellar.
echo "[Run] brew cleanup"
brew cleanup

