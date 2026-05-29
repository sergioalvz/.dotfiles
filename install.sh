#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "${CODESPACES:-}" == "true" ]]; then
  exec "$DOTFILES_DIR/codespaces/install.sh"
else
  exec "$DOTFILES_DIR/macos/install.sh"
fi
