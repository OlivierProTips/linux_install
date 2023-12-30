#!/bin/bash

if [[ -z $1 || ($1 != "ARM64" && $1 != "AMD64") ]]
then
    echo "Use AMD64 or ARM64 as parameter"
    exit
fi

cd /tmp
mkdir -p kali_install
cd kali_install

# VSCODE
sudo apt install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=${1,,}] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install code -y

code --install-extension donjayamanne.python-extension-pack --force
code --install-extension donjayamanne.git-extension-pack --force
code --install-extension ms-vscode.sublime-keybindings --force

# TERMINATOR
sudo apt install terminator -y
wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/Terminator/config
mkdir -p ~/.config/terminator
mv config ~/.config/terminator/config

# VIM
mv .vimrc ~

# ZSH
mv .zshrc ~

# UPLOAD
wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/scripts/upload_file_wget.sh
sudo mv upload_file_wget.sh /usr/local/bin
sudo chmod +x /usr/local/bin/upload_file_wget.sh

# MONIP
wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/scripts/monip.sh
sudo mv monip.sh /usr/local/bin
sudo chmod +x /usr/local/bin/monip.sh
sudo ln -s /usr/local/bin/monip.sh /usr/local/bin/monip

# NMAPER
wget https://raw.githubusercontent.com/OlivierProTips/nmaper/master/nmaper.py
sudo mv nmaper.py /usr/local/bin
sudo chmod +x /usr/local/bin/nmaper.py
sudo ln -s /usr/local/bin/nmaper.py /usr/local/bin/nmaper
