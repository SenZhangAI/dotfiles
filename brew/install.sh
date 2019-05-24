#!/usr/bin/env bash

# disable homebrew update, it's too slow!
export HOMEBREW_NO_AUTO_UPDATE=true

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install `wget` with IRI support.
brew install wget

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
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

brew install golang

brew cask install iterm2
brew cask install qq
brew cask install nutstore
brew cask install iina
brew cask install shadowsocksx-ng
# brew cask install visual-studio-code ## too slow
brew cask install teamviewer
brew cask install google-chrome
brew cask install thunder
brew cask install downie # download videos from youtube youku bilibili vimeo etc.
brew cask install goland
brew cask install pycharm

# Remove outdated versions from the cellar.
brew cleanup
