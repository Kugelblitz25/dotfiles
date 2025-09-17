#!/bin/bash

echo "🚀 Setting up Dotfiles and Personal Configuration..."

# 1. Stow Configurations
if [ -d "$HOME/dotfiles" ]; then
  cd ~/dotfiles
  echo "Stowing configuration files..."
  for dir in */; do
    stow "${dir%/}"
  done
  cd ~
else
  echo "Dotfiles directory not found. Skipping stow."
  exit 1
fi

# 2. Setup Firefox Custom CSS
echo "Linking Firefox userChrome.css..."
FIREFOX_PROFILE_DIR=$(find ~/.mozilla/firefox/ -name "*.default-release")
if [ -n "$FIREFOX_PROFILE_DIR" ]; then
  CHROME_DIR="$FIREFOX_PROFILE_DIR/chrome"
  mkdir -p "$CHROME_DIR"
  [cite_start]ln -sf ~/dotfiles/firefox/chrome/userChrome.css "$CHROME_DIR/userChrome.css" [cite: 1]
  echo "Firefox chrome symlink created."
else
  echo "Could not find Firefox default profile directory."
fi

echo "✅ Dotfiles Setup Complete! Please restart your system for all changes to take effect."
