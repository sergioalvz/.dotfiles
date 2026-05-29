# --- Portable aliases --------------------------------------------------------
alias g="git"

# --- Tool-enhanced aliases (only set when the tool is available) -------------
if command -v eza &>/dev/null; then
  alias ls="eza"
  alias ll="eza -la --git --icons"
  alias lt="eza --tree --level=2 --icons"
fi

if command -v bat &>/dev/null; then
  alias cat="bat --paging=never"
fi
