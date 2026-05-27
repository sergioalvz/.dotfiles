#!/usr/bin/env bash
# Minimal macOS overrides for day-to-day software dev work.
# No security tweaks — those are managed by the company MDM profile.
# No sudo required. Re-runnable.

set -u

echo "Applying macOS dev defaults..."

# Close System Settings so it doesn't override what we change.
osascript -e 'tell application "System Preferences" to quit' || true

# --- Keyboard: fast key repeat (the single biggest dev quality-of-life win) -
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# --- Disable smart-quote / dash substitution in native apps (Notes, Mail) ---
# Stops pasted "code" snippets from turning into "smart" quotes.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# --- Finder: show extensions + path bar + status bar + list view by default -
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"  # search current folder, not whole Mac

# --- Dock: stable Spaces ----------------------------------------------------
# Don't rearrange virtual desktops by recent use — keeps Ctrl-1 / Ctrl-2 muscle memory.
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock show-recents -bool false

# --- Screenshots: dedicated folder so the Desktop stays clean ---------------
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location "$HOME/Screenshots"

# Restart affected apps so changes take effect now.
killall Finder Dock &>/dev/null || true

echo "Done."
