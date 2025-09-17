#!/bin/bash

echo "🚀 Installing CLI Tools & Shell..."

# 1. Install Essential CLI Packages from APT
echo "Installing core CLI tools from APT..."
sudo apt install -y \
  git tmux zsh btop stow fzf ripgrep fd-find bat neofetch ncal xclip dconf-cli curl nano
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
rm lazygit.tar.gz
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# 2. Install Oh My Posh
echo "Installing Oh My Posh..."
curl -s https://ohmyposh.dev/install.sh | bash -s

# 3. Install Starship Prompt
echo "Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

# 4. Install Neovim (AppImage method from your history)
echo "Installing Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
echo "Neovim installed to /opt/nvim-linux-x86_64/. Ensure this is in your PATH via .zshrc."

# 5. Change Default Shell to Zsh
echo "Changing default shell to Zsh. You will need to log out and back in for this to take full effect."
chsh -s $(which zsh)

echo "✅ CLI Tools & Shell Setup Complete!"
