#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
echo "brew update"
brew update

# Upgrade any already-installed formulae.
echo "brew upgrade"
brew upgrade

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

# Remove outdated versions from the cellar.
brew cleanup
