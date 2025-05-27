#!/usr/bin/env bash

echo
echo "Installing Homebrew..."
echo
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi
brew bundle

echo
echo "Installing Zsh..."
echo
if ! grep -q "$(which zsh)" /etc/shells; then
  sudo bash -c "echo $(which zsh) >> /etc/shells"
else
  echo "Zsh is already in /etc/shells."
fi
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s $(which zsh)
else
  echo "Zsh is already the default shell."
fi

echo
echo "Installing Oh My Zsh..."
echo
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh is already installed."
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
  echo "zsh-syntax-highlighting plugin is already installed."
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else
  echo "zsh-autosuggestions plugin is already installed."
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt" ]; then
  git clone https://github.com/denysdovhan/spaceship-prompt.git "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt"
  ln -s "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
else
  echo "spaceship-prompt theme is already installed."
  if [ ! -f "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme" ]; then
    ln -s "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
  fi
fi

mkdir -p $HOME/.oh-my-zsh/custom/plugins/nvm-auto-use
if [ ! -f "$HOME/.oh-my-zsh/custom/plugins/nvm-auto-use/nvm-auto-use.plugin.zsh" ]; then
  curl https://raw.githubusercontent.com/tomsquest/nvm-auto-use.zsh/master/nvm-auto-use.zsh -o $HOME/.oh-my-zsh/custom/plugins/nvm-auto-use/nvm-auto-use.plugin.zsh
else
  echo "nvm-auto-use plugin is already installed."
fi

echo
echo "Installing dotfiles..."
echo
# These commands are already idempotent with ln -nfsv
ln -nfsv $(pwd)/git/gitconfig $HOME/.gitconfig
ln -nfsv $(pwd)/git/gitignore_global $HOME/.gitignore_global
mkdir -p $HOME/Library/Application\ Support/Code/User && ln -nfsv $(pwd)/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
ln -nfsv $(pwd)/zsh/zshrc $HOME/.zshrc
mkdir -p $HOME/.ssh && ln -nfsv $(pwd)/ssh/config $HOME/.ssh/config
