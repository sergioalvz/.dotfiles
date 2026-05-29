#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo
echo "Installing Oh My Zsh..."
echo
if [ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
  if [ -d "$HOME/.oh-my-zsh" ]; then
    mv "$HOME/.oh-my-zsh" "$HOME/.oh-my-zsh.bak.$$"
  fi
  KEEP_ZSHRC=yes RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
  if [ -d "$HOME/.oh-my-zsh.bak.$$/custom" ]; then
    cp -R "$HOME/.oh-my-zsh.bak.$$/custom/." "$HOME/.oh-my-zsh/custom/"
    rm -rf "$HOME/.oh-my-zsh.bak.$$"
  fi
else
  echo "Oh My Zsh is already installed."
fi

# zsh-syntax-highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting plugin..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
else
  echo "zsh-syntax-highlighting plugin is already installed."
fi

# zsh-autosuggestions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions plugin..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
else
  echo "zsh-autosuggestions plugin is already installed."
fi

echo
echo "Installing Starship prompt..."
echo
if ! command -v starship &>/dev/null; then
  curl -sS https://starship.rs/install.sh | sh -s -- --yes
else
  echo "Starship is already installed."
fi

echo
echo "Linking dotfiles..."
echo

# ~/.gitconfig is generated (not symlinked) so that commands like
# `git config --global` write to an untracked file instead of into the repo.
cat > "$HOME/.gitconfig" <<EOF
[include]
  path = $DOTFILES_DIR/git/gitconfig_shared
  path = $DOTFILES_DIR/codespaces/gitconfig
EOF

ln -nfsv "$DOTFILES_DIR/git/gitignore_global"   "$HOME/.gitignore_global"
ln -nfsv "$DOTFILES_DIR/codespaces/zshrc"       "$HOME/.zshrc"

echo
echo "Codespaces setup completed!"
echo
