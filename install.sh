#!/usr/bin/env bash

# Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew bundle

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

# zsh
sudo bash -c "echo $$(which zsh) >> /etc/shells"
chsh -s $(which zsh)
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh -l::g' | sed 's:chsh -s .*$$::g'
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
mkdir -p ~/.oh-my-zsh/custom/plugins/nvm-auto-use && curl https://raw.githubusercontent.com/tomsquest/nvm-auto-use.zsh/master/nvm-auto-use.zsh -o ~/.oh-my-zsh/custom/plugins/nvm-auto-use/nvm-auto-use.plugin.zsh

# Dotfiles
ln -nfsv $(pwd)/git/gitconfig ~/.gitconfig
ln -nfsv $(pwd)/git/gitignore_global ~/.gitignore_global
mkdir -p ~/Library/Application\ Support/Code/User && ln -nfsv $(pwd)/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -nfsv $(pwd)/zsh/zshrc ~/.zshrc
ln -nfsv $(pwd)/zsh/themes/nenu.zsh-theme ~/.oh-my-zsh/themes/nenu.zsh-theme
ln -nfsv $(pwd)/hyper/hyper.js ~/.hyper.js
mkdir -p ~/.ssh && ln -nfsv $(pwd)/ssh/config ~/.ssh/config
