#!/usr/bin/env bash

echo
echo "Installing Homebrew..."
echo
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle

echo
echo "Installing nvm..."
echo
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

echo
echo "Installing Zsh..."
echo
sudo bash -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

echo
echo "Installing Oh My Zsh..."
echo
curl -L http://install.ohmyz.sh | sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/denysdovhan/spaceship-prompt.git "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt" && ln -s "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
mkdir -p $HOME/.oh-my-zsh/custom/plugins/nvm-auto-use && curl https://raw.githubusercontent.com/tomsquest/nvm-auto-use.zsh/master/nvm-auto-use.zsh -o $HOME/.oh-my-zsh/custom/plugins/nvm-auto-use/nvm-auto-use.plugin.zsh

echo
echo "Setting up iTerm2..."
echo
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$(pwd)/iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true


echo
echo "Installing dotfiles..."
echo
ln -nfsv $(pwd)/git/gitconfig $HOME/.gitconfig
ln -nfsv $(pwd)/git/gitignore_global $HOME/.gitignore_global
mkdir -p $HOME/Library/Application\ Support/Code/User && ln -nfsv $(pwd)/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
ln -nfsv $(pwd)/zsh/zshrc $HOME/.zshrc
ln -nfsv $(pwd)/zsh/themes/nenu.zsh-theme $HOME/.oh-my-zsh/themes/nenu.zsh-theme
ln -nfsv $(pwd)/hyper/hyper.js $HOME/.hyper.js
mkdir -p $HOME/.ssh && ln -nfsv $(pwd)/ssh/config $HOME/.ssh/config
