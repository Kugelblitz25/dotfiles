#!/bin/bash

echo "🚀 Installing GUI Apps & Theming..."

# 1. Install GUI Applications
echo "Installing desktop applications..."
sudo apt install -y \
  firefox \
  thunderbird vlc \
  gnome-tweaks \
  gnome-shell-extensions \
  gnome-shell-extension-manager \
  libreoffice-calc \
  gnome-calendar \
  conky-all

# 2. Install VS Code
echo "Installing Visual Studio Code..."
sudo apt-get install -y wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update
sudo apt install -y code

# 3. Install Fonts (JetBrains Mono)
echo "Installing JetBrains Mono font..."
mkdir -p ~/.fonts
curl -Lo JetBrainsMono.zip https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
unzip -d ~/.fonts JetBrainsMono.zip "*.ttf"
rm JetBrainsMono.zip
fc-cache -fv

# 4. Install GTK and Terminal Themes
echo "Installing Catppuccin theme for GNOME Terminal..."
curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v1.0.0/install.py | python3 -

echo "✅ GUI Apps & Theming Complete!"
