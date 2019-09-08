#!/usr/bin/env bash

# using proxy
#export ALL_PROXY=http://127.0.0.1:1087

echo "[Config] change mirrors for Homebrew..."
#see https://mirrors.ustc.edu.cn
cd "$(brew --repo)" && git remote set-url origin https://mirrors.ustc.edu.cn/brew.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core" && git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-cask" && git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git
# export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-cask.git
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

# Universal Ctags instead of Exuberant Ctags
brew install ctags
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

brew cask install julia
brew cask install iterm2
brew cask install shadowsocksx-ng
brew cask install alfred
brew cask install qq
brew cask install wechat
brew cask install nutstore && open $(brew --prefix)/Caskroom/nutstore/latest &
brew cask install iina
brew cask install teamviewer
brew cask install google-chrome
brew cask install thunder

## NTFS Support for MAC
### see https://devstudioonline.com/article/enable-ntfs-file-system-in-mac-os-mojave
brew cask install osxfuse
brew install ntfs-3g

######################## OPTIONAL APPLICATION #########################
#brew cask install flash-player

#brew install gsmartcontrol ## a GUI app show S.M.A.R.T message of disk
#brew install aliwangwang
#brew install node
#brew install yarn
#brew install ghc
#brew cask install hammerspoon

#brew cask install kindle
#brew cask install calibre

#brew install sqlite
#brew install mysqlworkbench
#brew install mycli
#brew cask install sequel-pro ## the newest version is better, see https://sequelpro.com/test-builds

#brew install protobuf
#brew cask install visual-studio-code ## too slow
#brew cask install goland
#brew install ruby
#brew install nim
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

#######################################################################

# Remove outdated versions from the cellar.
echo "[Run] brew cleanup"
brew cleanup

