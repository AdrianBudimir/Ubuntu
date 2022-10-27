#! /usr/bin/env bash

echo Trimble VPN Certificate script ; echo Make sure up have downloaded the Certificate file from your email to the ~/Downloads folder
read -s -n 1 -p "If ready, press any key to continue..."
echo
sudo snap remove firefox && sudo add-apt-repository ppa:mozillateam/ppa
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
sudo apt install firefox
mkdir -p ~/.cisco/certificates/ca/ && mkdir -p ~/.cisco/certificates/client && mkdir -p ~/.cisco/certificates/client/private

openssl pkcs12 -legacy -in ~/Downloads/*.pfx -nocerts -out ~/.cisco/certificates/ca/CAs.pem -nodes && openssl pkcs12 -legacy -in ~/Downloads/*.pfx -clcerts -nokeys -out ~/.cisco/certificates/client/CL.pem -nodes && openssl rsa -in ~/.cisco/certificates/ca/CAs.pem -out ~/.cisco/certificates/client/private/CL.key && openssl pkcs12 -legacy -in ~/Downloads/*.pfx -cacerts -nokeys -chain -out ~/.cisco/certificates/ca/CA.pem

echo Thanks!
cd /tmp
wget https://cis-infosec-cdn.trimble.com/trimbleify-linux-workstation.sh
read -s -n 1 -p "The Trimbleify script was downloaded to your /tmp folder. Press any key to close this script. Browse to your /tmp folder open a terminal and run the command (sudo bash trimbleify-linux-workstation.sh"
echo Thanks!
