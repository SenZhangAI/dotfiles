#!/usr/bin/env bash

#install Homebrew

if ! command -v brew >/dev/null 2>&1; then
    printf "Brew is not installed! Install brew...\n"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if ! command -v git >/dev/null 2>&1; then
    printf "git is not installed! Install git...\n"
    brew install git
fi

echo "Change mirrors for Homebrew"
#see https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/
cd "$(brew --repo)"
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git

export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles

#cd "$(brew --repo)" && git remote set-url origin https://git.coding.net/homebrew/homebrew.git

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
