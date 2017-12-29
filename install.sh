#!/bin/bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install git
brew install zsh

brew tap caskroom/fonts
brew cask install font-fira-code
brew cask install google-chrome
brew cask install iterm2
brew cask install visual-studio-code

# TODO: Install oh-my-zsh
# TODO: Make zsh the default shell

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# TODO: Symlink files

echo 'ATTENTION: Remember to source your .zshrc'
