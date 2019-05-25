#!/usr/bin/env bash

# using proxy
#export ALL_PROXY=socks5://127.0.0.1:1086
#export ALL_PROXY=http://127.0.0.1:1087

# disable homebrew update, it's too slow!
export HOMEBREW_NO_AUTO_UPDATE=true

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install `wget` with IRI support.
brew install wget

# Install more recent versions of some macOS tools.
brew install macvim
brew install neovim
brew install grep
brew install openssh

brew install cmake
brew install ctags
brew install fzf
brew install git
brew install perl
brew install tldr
brew install tmux
brew install tree
brew install xz
brew install clang-format
brew install global # for gtags

brew cask install iterm2
brew cask install shadowsocksx-ng
brew cask install alfred
brew cask install hammerspoon
brew cask install qq
brew cask install wechat
brew cask install nutstore
brew cask install iina
# brew cask install visual-studio-code ## too slow
brew cask install teamviewer
brew cask install google-chrome
brew cask install thunder

# Remove outdated versions from the cellar.
brew cleanup

