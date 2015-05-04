#!/usr/bin/env bash
set -eu

#
# Binary installer
#

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

# Install other useful binaries
binaries=(
  graphicsmagick
  rename
  python
  node
  tree
  hub
  ack
  git
  hub
  fig
  ansible
  git-flow
  htop
)

# Install the binaries
brew install ${binaries[@]}

# Add osx specific command line tools
#if test ! $(which subl); then
#  ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
#fi

# Install spot
#if test ! $(which spot); then
#  curl -L https://raw.github.com/guille/spot/master/spot.sh -o /usr/local/bin/spot && chmod +x /usr/local/bin/spot
#fi

# Remove outdated versions from the cellar
brew cleanup

if test ! $(which rvm); then
  echo "Installing rvm..."
  curl -sSL https://get.rvm.io | bash -s stable
fi

if [ ! -f $HOME/.nvm/nvm.sh ]; then
  echo "Installing nvm..."
  curl https://raw.githubusercontent.com/creationix/nvm/v0.25.1/install.sh | bash
fi


exit 0
