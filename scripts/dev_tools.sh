#!/bin/bash

echo "🚀 Setting up Development Environments..."

# 1. Install Rust and common tools
echo "Installing Rust via rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# Source cargo env to use it immediately
source "$HOME/.cargo/env"
echo "Installing 'eza' with cargo..."
cargo install eza

# 2. Install Go
echo "Installing Go..."
curl -LO https://go.dev/dl/go1.25.1.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.25.1.linux-amd64.tar.gz
rm go1.25.1.linux-amd64.tar.gz
echo "Go installed. Ensure /usr/local/go/bin is in your PATH via .zshrc."

# 3. Install Docker
echo "Setting up Docker..."
# Remove old versions
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove -y $pkg; done
# Add Docker's official GPG key
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update
# Install Docker Engine
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Add user to the docker group
sudo usermod -aG docker $USER
echo "Docker installed. You need to log out and back in to use Docker without sudo."

# 4. Install Python build dependencies and uv
echo "Installing Python dependencies and uv..."
sudo apt-get install -y build-essential python3.12-venv portaudio19-dev libportaudio2 libportaudio-dev [cite: 16, 22]
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "✅ Development Environments Setup Complete!"
