#!/bin/bash

# aarch64
# 
archi=$(uname -m)
if [[ "${archi}" == "aarch64" || "${archi}" == "arm64" ]]; then
    arch="arm64"
else
    arch="x64"
fi

# if [[ -z $1 || ($1 != "ARM64" && $1 != "AMD64") ]]
# then
#     echo "Use AMD64 or ARM64 as parameter"
#     exit
# fi

sudo DEBIAN_FRONTEND=noninteractive apt update
# sudo DEBIAN_FRONTEND=noninteractive apt dist-upgrade -y

# VSCODE
echo "=============================="
echo "Installing VSCODE ${archi}/${arch}"
echo "=============================="
wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-${arch}" -O vscode.deb
sudo apt install ./vscode.deb

# code --install-extension donjayamanne.python-extension-pack --force
# code --install-extension donjayamanne.git-extension-pack --force
# code --install-extension ms-vscode.sublime-keybindings --force
# code --install-extension mechatroner.rainbow-csv --force
# code --install-extension netcorext.uuid-generator --force
# code --install-extension neptunedesign.vs-sequential-number --force
# code --install-extension raidou.calc --force
# code --install-extension nemesv.copy-file-name --force
# code --install-extension jsynowiec.vscode-insertdatestring --force

# TERMINATOR
echo "=============================="
echo "Installing TERMINATOR"
echo "=============================="
sudo apt install terminator -y
wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/Terminator/config
mkdir -p ~/.config/terminator
mv config ~/.config/terminator/config

# ROCKYOU
echo "=============================="
echo "Installing ROCKYOU"
echo "=============================="
sudo gunzip -d /usr/share/wordlists/rockyou.txt.gz

# SECLISTS
echo "=============================="
echo "Installing SECLISTS"
echo "=============================="
sudo apt install seclists -y

# FEROXBUSTER
echo "=============================="
echo "Installing FEROXBUSTER"
echo "=============================="
sudo apt install feroxbuster -y

# GOBUSTER
echo "=============================="
echo "Installing GOBUSTER"
echo "=============================="
sudo apt install gobuster -y

# PWNCAT-CS
echo "=============================="
echo "Installing PWNCAT-CS"
echo "=============================="
sudo DEBIAN_FRONTEND=noninteractive apt install python3.10-venv -y
mkdir ~/Tools
python3 -m venv ~/Tools/pwncat-env
source ~/Tools/pwncat-env/bin/activate
pip install pwncat-cs
deactivate

# VIM
echo "=============================="
echo "Setting VIM"
echo "=============================="
echo 'source $VIMRUNTIME/defaults.vim' >> ~/.vimrc
echo 'set mouse-=a' >> ~/.vimrc
sudo echo 'source $VIMRUNTIME/defaults.vim' >> /root/.vimrc
sudo echo 'set mouse-=a' >> /root/.vimrc

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
mv less.sh ~
chmod +x ~/less.sh
if [[ -d ~/Desktop ]]
then
    mv ~/less.sh ~/Desktop
fi

# BURPSUITE
if [[ ${arch} == "arm64" ]]
then
    echo "=============================="
    echo "Installing BURPSUITE"
    echo "=============================="
    wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/scripts/burpsuite
    sudo mv burpsuite /usr/local/bin
    sudo chmod +x /usr/local/bin/burpsuite
    sudo /usr/local/bin/burpsuite -u
fi

# VPNCHOICE
echo "=============================="
echo "Installing VPNCHOICE"
echo "=============================="
wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/scripts/vpnchoice.py
sudo mv vpnchoice.py /usr/local/bin/vpnchoice
sudo chmod +x /usr/local/bin/vpnchoice
echo "alias vpnchoice='sudo vpnchoice'" >> ~/.zshrc
sudo python3 -m pip install simple-term-menu

# MANUAL STEPS
echo " ------------------------------------- "
echo "| MANUAL STEPS                        |"
echo " ------------------------------------- "
echo "| Set Default application: Terminator |"
echo "| Synchronize VSCode                  |"
echo "| Certificat burpsuite                |"
echo "| FoxyProxy in Firefox                |"
echo "| HackTools in Firefox                |"
echo "| browser.urlbar.trimURLs in Firefox  |"
echo " ------------------------------------- "