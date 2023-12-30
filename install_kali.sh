#!/bin/bash

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

sudo DEBIAN_FRONTEND=noninteractive apt update
sudo DEBIAN_FRONTEND=noninteractive apt dist-upgrade -y

# VSCODE
# echo "=============================="
# echo "Installing VSCODE"
# echo "=============================="
# sudo apt install software-properties-common apt-transport-https wget -y
# wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
# sudo add-apt-repository "deb [arch=${arch,,}] https://packages.microsoft.com/repos/vscode stable main"
# sudo apt update
# sudo apt install code -y

# code --install-extension donjayamanne.python-extension-pack --force
# code --install-extension donjayamanne.git-extension-pack --force
# code --install-extension ms-vscode.sublime-keybindings --force

# TERMINATOR
echo "=============================="
echo "Installing TERMINATOR"
echo "=============================="
sudo apt install terminator -y
wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/Terminator/config
mkdir -p ~/.config/terminator
mv config ~/.config/terminator/config

# PWNCAT-CS
echo "=============================="
echo "Installing PWNCAT-CS"
echo "=============================="
sudo pip install pwncat-cs

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
sudo mv upload_file_wget.sh /usr/local/bin/upload_file_wget
sudo chmod +x /usr/local/bin/upload_file_wget

# MONIP
echo "=============================="
echo "Installing MONIP"
echo "=============================="
wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/scripts/monip.sh
sudo mv monip.sh /usr/local/bin/monip
sudo chmod +x /usr/local/bin/monip

# NMAPER
echo "=============================="
echo "Installing NMAPER"
echo "=============================="
wget https://raw.githubusercontent.com/OlivierProTips/nmaper/master/nmaper.py
sudo mv nmaper.py /usr/local/bin/nmaper
sudo chmod +x /usr/local/bin/nmaper

# LESS
echo "=============================="
echo "Installing LESS"
echo "=============================="
sudo mv less.sh /usr/local/bin

# BURPSUITE
echo "=============================="
echo "Installing BURPSUITE"
echo "=============================="
sudo mv burp* /usr/local/bin
sudo chmod +x /usr/local/bin/burp*
echo
echo "DO NOT FORGET TO DOWNLOAD BURPSUITE JAR AND INSTALL IT WITH burp_update"
echo

# VPNCHOICE
echo "=============================="
echo "Installing VPNCHOICE"
echo "=============================="
wget https://github.com/OlivierProTips/HackNotes/blob/main/scripts/vpnchoice.py
sudo mv vpnchoice.py /usr/local/bin/vpnchoice
sudo chmod +x /usr/local/bin/vpnchoice
echo "alias vpnchoice='sudo vpnchoice'" >> ~/.zshrc

# VSCODE
echo "=============================="
echo "Installing VSCODE"
echo "=============================="
echo
echo "BEFORE CONTINUING"
echo "Download VSCode from https://code.visualstudio.com/download "
echo "and INSTALL it: sudo dpkg -i <vscode.deb>"
echo
read -p "Press any key to continue ..."
# code --install-extension donjayamanne.python-extension-pack --force
# code --install-extension donjayamanne.git-extension-pack --force
# code --install-extension ms-vscode.sublime-keybindings --force
# code --install-extension mechatroner.rainbow-csv --force
# code --install-extension netcorext.uuid-generator --force
# code --install-extension neptunedesign.vs-sequential-number --force
# code --install-extension raidou.calc --force
# code --install-extension nemesv.copy-file-name --force
# code --install-extension jsynowiec.vscode-insertdatestring --force

# MANUAL STEPS
# Default application: Terminator
# Synchronize VSCode