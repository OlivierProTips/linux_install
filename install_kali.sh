#!/bin/bash

# Launch script as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# aarch64
# 
archi=$(uname -m)
if [[ "${archi}" == "aarch64" || "${archi}" == "arm64" ]]; then
    arch="arm64"
else
    arch="amd64"
fi

# if [[ -z $1 || ($1 != "ARM64" && $1 != "AMD64") ]]
# then
#     echo "Use AMD64 or ARM64 as parameter"
#     exit
# fi

export DEBIAN_FRONTEND=noninteractive

apt update && apt dist-upgrade -y

# VSCODE
echo "=============================="
echo "Installing VSCODE"
echo "=============================="
apt install software-properties-common apt-transport-https wget -y
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
add-apt-repository "deb [arch=${arch,,}] https://packages.microsoft.com/repos/vscode stable main"
apt update
apt install code -y

# code --install-extension donjayamanne.python-extension-pack --force
# code --install-extension donjayamanne.git-extension-pack --force
# code --install-extension ms-vscode.sublime-keybindings --force

# TERMINATOR
echo "=============================="
echo "Installing TERMINATOR"
echo "=============================="
apt install terminator -y
wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/Terminator/config
mkdir -p ~/.config/terminator
mv config ~/.config/terminator/config

# VIM
echo "=============================="
echo "Setting VIM"
echo "=============================="
mv .vimrc ~

# ZSH
echo "=============================="
echo "Setting ZSH"
echo "=============================="
mv .zshrc ~

# UPLOAD
echo "=============================="
echo "Installing UPLOAD"
echo "=============================="
wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/scripts/upload_file_wget.sh
mv upload_file_wget.sh /usr/local/bin/upload_file_wget
chmod +x /usr/local/bin/upload_file_wget

# MONIP
echo "=============================="
echo "Installing MONIP"
echo "=============================="
wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/scripts/monip.sh
mv monip.sh /usr/local/bin/monip
chmod +x /usr/local/bin/monip

# NMAPER
echo "=============================="
echo "Installing NMAPER"
echo "=============================="
wget https://raw.githubusercontent.com/OlivierProTips/nmaper/master/nmaper.py
mv nmaper.py /usr/local/bin/nmaper
chmod +x /usr/local/bin/nmaper

# ip_widget
echo "=============================="
echo "Installing ip_widget"
echo "=============================="
wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/scripts/ip_widget.sh
mv ip_widget.sh ~/Documents

# LESS
echo "=============================="
echo "Installing LESS"
echo "=============================="
if [[ -d ~/Desktop ]]
then
    mv less.sh ~/Desktop
elif [[ -d ~/Bureau ]]
then
    mv less.sh ~/Bureau
else
    echo "less.sh has not been moved"
fi

# BURPSUITE
echo "=============================="
echo "Installing BURPSUITE"
echo "=============================="
mv burp* /usr/local/bin
chmod +x /usr/local/bin/burp*