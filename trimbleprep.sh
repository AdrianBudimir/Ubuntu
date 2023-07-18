#! /usr/bin/env bash

# Get the Trimble scripts

wget https://raw.githubusercontent.com/AdrianBudimir/Ubuntu/main/vpnscript.sh -o vpnscript.sh
wget https://raw.githubusercontent.com/AdrianBudimir/Ubuntu/main/trimbleify-linux-workstation.sh -o trimbleify-linux-workstation.sh

# change keyboard & locales

sudo dpkg-reconfigure keyboard-configuration && sudo dpkg-reconfigure locales && sudo dpkg-reconfigure tzdata

# intro

Red=$'\e[1;31m'
Green=$'\e[1;32m'
Blue=$'\e[1;34m'

echo $'\e[1;34m' " Closeing FireFox if you have it opened ! "$'\e[0m'

sudo pkill -f firefox
sudo apt-get purge transmission-gtk

# remove snap & change prio

echo
sudo snap remove firefox && sudo add-apt-repository ppa:mozillateam/ppa
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

# install deb FFox

sudo apt install firefox

# Install Intune
# Install dependencies
sudo apt update
sudo apt install -y apt-transport-https curl gpg

# Download and install the signing key
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/

# Add the Intune repository
echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list
echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" | sudo tee -a /etc/apt/sources.list.d/microsoft-edge.list

sudo rm microsoft.gpg

# Update package list
sudo apt update

# Install Intune management extension agent
sudo apt install -y mdatp intune-portal microsoft-edge-stable

# Trimblefy prep

Sudo apt update && sudo apt upgrade -y
sudo mv /opt/trimbleify-linux-workstation.sh /tmp/trimbleify-linux-workstation.sh

read -s -n 1 -p "The Trimbleify script was downloaded to your /tmp folder. Press any key to close this script. Browse to your /tmp folder open a terminal and run the command (sudo bash trimbleify-linux-workstation.sh"
echo -e $'\e[1;34m' "\Connect to VPN if you are not in a Trimble Office for the next part!!!"$'\e[0m'

read -s -n 1 -p "Thanks!"