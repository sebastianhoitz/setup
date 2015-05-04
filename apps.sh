#!/usr/bin/env bash
set -eu

#
# Application installer (via brew-cask)
#

# Apps
apps=(
  alfred
  1password
  dropbox
  google-chrome
  transmit
  firefox
  spotify
  vagrant
  arq
  iterm2
  virtualbox
  atom
  vlc
  quicklook-json
  skype
  transmission
  mysqlworkbench
  poedit
  wireshark
  macvim
  hyperdock
  hipchat
  sourcetree
  phpstorm
  tunnelblick
)

# fonts
fonts=(
  font-m-plus
  font-clear-sans
  font-roboto
  font-inconsolata-dz-for-powerline
)

# Atom packages
atom=(
  advanced-railscasts-syntax
  atom-beautify
  cmd-9
  color-picker
  css-comb
  docblockr
  easy-motion
  editor-stats
  emmet
  fancy-new-file
  file-icons
  git-history
  highlight-selected
  image-view
  inc-dec-value
  key-peek
  language-jade
  linter
  markdown-preview
  merge-conflicts
  neutron-ui
  npm-install
  react
  vim-mode
  zentabs
)

# Specify the location of the apps
appdir="/Applications"

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

main() {

  # Ensure homebrew is installed
  homebrew

  # Install homebrew-cask
  echo "installing cask..."
  brew tap phinze/homebrew-cask
  brew install brew-cask

  # Tap alternative versions
  brew tap caskroom/versions

  # Tap the fonts
  brew tap caskroom/fonts

  # install apps
  echo "installing apps..."
  brew cask install --appdir=$appdir ${apps[@]}

  # install fonts
  echo "installing fonts..."
  brew cask install ${fonts[@]}

  # install atom plugins
  echo "installing atom plugins..."
  apm install ${atom[@]}

  # link with alfred
  alfred
  cleanup
}

homebrew() {
  if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

alfred() {
  brew cask alfred link
}

cleanup() {
  brew cleanup
}

main "$@"
exit 0
