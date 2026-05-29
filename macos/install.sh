#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo
echo "Installing Xcode Command Line Tools..."
echo
if ! xcode-select -p &>/dev/null; then
  xcode-select --install || true
  echo "Re-run this script once the Xcode CLT installer finishes."
  exit 0
else
  echo "Xcode Command Line Tools are already installed."
fi

echo
echo "Installing Homebrew..."
echo
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "Homebrew is already installed."
fi
brew bundle --file="$DOTFILES_DIR/Brewfile"

echo
echo "Configuring Zsh..."
echo
if ! grep -q "$(which zsh)" /etc/shells &>/dev/null; then
  sudo bash -c "echo $(which zsh) >> /etc/shells"
else
  echo "Zsh is already in /etc/shells."
fi

if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Changing default shell to Zsh..."
  chsh -s "$(which zsh)"
else
  echo "Zsh is already the default shell."
fi

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
echo "Symlinking dotfiles..."
echo
ln -nfsv "$DOTFILES_DIR/macos/gitconfig"        "$HOME/.gitconfig"
ln -nfsv "$DOTFILES_DIR/git/gitignore_global"   "$HOME/.gitignore_global"
ln -nfsv "$DOTFILES_DIR/macos/zshrc"             "$HOME/.zshrc"

git config --global include.path "$DOTFILES_DIR/git/gitconfig_shared"

mkdir -p "$HOME/Library/Application Support/Code/User"
ln -nfsv "$DOTFILES_DIR/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"

mkdir -p "$HOME/.ssh"
ln -nfsv "$DOTFILES_DIR/ssh/config"           "$HOME/.ssh/config"

echo
read -r -p "Apply opinionated macOS defaults (key repeat, Finder, Dock)? [y/N] " response
if [[ "$response" =~ ^[Yy]$ ]]; then
  bash "$DOTFILES_DIR/macos/defaults.sh"
fi

echo
echo "Installation completed successfully!"
echo "Next steps:"
echo "  1. Restart your terminal (or 'exec zsh') to load the new shell config."
echo "  2. Run 'gh auth login' if you haven't already."
echo "  3. Sign in to 1Password and enable the SSH agent in Settings > Developer."
echo "     The SSH key syncs from your vault; commit signing is already configured."
echo "  4. Set per-repo git identity:  git config user.email you@example.com"
echo "  5. Install runtimes with mise, e.g. 'mise use --global node@lts python@3.13 ruby@3.3'."
echo
