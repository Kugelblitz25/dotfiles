#!/bin/bash

echo "🚀 Starting System Preparation..."

# 1. Update and Upgrade System Packages
sudo apt update && sudo apt upgrade -y

# 2. Remove Snap and its related services
echo "Removing Snapd and installed Snap packages..."
for pkg in $(snap list | awk 'NR>1 {print $1}'); do sudo snap remove --purge "$pkg"; done
sudo systemctl stop snapd snapd.socket
sudo systemctl disable snapd snapd.socket
sudo systemctl mask snapd
sudo apt purge snapd -y
sudo rm -rf ~/snap /snap /var/snap /var/lib/snapd

# 3. Configure APT to block Snapd
echo "Disabling Snapd in APT preferences..."
echo '
Package: snapd
Pin: release a=*
Pin-Priority: -10
' | sudo tee /etc/apt/preferences.d/nosnap.pref >/dev/null

# 4. Remove Ubuntu Telemetry and Reporting Tools
echo "Removing Ubuntu reporting and telemetry tools..."
sudo systemctl disable --now whoopsie.service motd-news.timer
sudo apt remove --purge -y whoopsie ubuntu-report popularity-contest apport landscape-common ubuntu-advantage-tools update-notifier

# 5. Add Mozilla PPA for the latest Firefox
echo "Adding Mozilla PPA for Firefox and Thunderbird..."
sudo add-apt-repository ppa:mozillateam/ppa -y
echo '
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 501
' | sudo tee /etc/apt/preferences.d/mozilla-firefox >/dev/null
echo '
Package: thunderbird*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 501
' | sudo tee /etc/apt/preferences.d/mozilla-thunderbird >/dev/null

# 6. Final cleanup
echo "Performing final cleanup..."
sudo apt update
sudo apt autopurge -y

echo "✅ System Preparation Complete!"
