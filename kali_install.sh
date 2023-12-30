#!/bin/bash

# Check if we are not root
if [ "$EUID" -eq 0 ]
then
    echo "ERROR: Please do not run as root"
    exit 1
fi

currentDir=$(pwd)

listDisplay() {

    # retrieve size of the longest string in myTask
    max_size=-1
    for x in "${myTasks[@]}"
    do
        if [ ${#x} -gt $max_size ]
        then
            max_size=${#x}
        fi
    done

    # Check if title is longer than longest string is myTasks
    if  [ ${#1} -gt $max_size ]; then max_size=${#1}; fi

    # Display with padding
    max_size=$(expr $max_size + 1)
    msg="| $1$(for ((i=${#1}; i<$max_size; i++)); do echo -n " "; done)|"
    edge="+$(for ((i=0; i<=$max_size; i++)); do echo -n "-"; done)+"
    echo "$edge"
    echo "$msg"
    echo "$edge"
    for task in "${myTasks[@]}"; do
        task_msg="| $task$(for ((i=${#task}; i<$max_size; i++)); do echo -n " "; done)|"
        echo "$task_msg"
    done
    echo "$edge"
}

banner() {
    msg="| $* |"
    edge="+-$(echo "$*" | sed 's/./-/g')-+"
    echo "$edge"
    echo "$msg"
    echo "$edge"
}

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
sudo DEBIAN_FRONTEND=noninteractive apt dist-upgrade -y

# VSCODE
banner "Installing VSCODE ${archi}/${arch}"
wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-${arch}" -O /tmp/vscode.deb
sudo apt install /tmp/vscode.deb
rm -f /tmp/vscode.deb

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
banner "Installing TERMINATOR"
sudo apt install terminator -y
mkdir -p ~/.config/terminator
wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/Terminator/config -O ~/.config/terminator/config

# ROCKYOU
banner "Installing ROCKYOU"
sudo gunzip -d /usr/share/wordlists/rockyou.txt.gz

# SECLISTS
banner "Installing SECLISTS"
sudo apt install seclists -y

# FEROXBUSTER
banner "Installing FEROXBUSTER"
sudo apt install feroxbuster -y

# GOBUSTER
banner "Installing GOBUSTER"
sudo apt install gobuster -y

# PWNCAT-CS
banner "Installing PWNCAT-CS"
sudo DEBIAN_FRONTEND=noninteractive apt install python3-pip python3.11-env -y
python3 -m pip install --user pipx
python3 -m pipx ensurepath
export PATH=/home/kali/.local/bin:$PATH
pipx install pwncat-cs


# VIM
banner "Setting VIM"
echo 'source $VIMRUNTIME/defaults.vim' >> ~/.vimrc
echo 'set mouse-=a' >> ~/.vimrc
sudo echo 'source $VIMRUNTIME/defaults.vim' >> /root/.vimrc
sudo echo 'set mouse-=a' >> /root/.vimrc

# ZSH
banner "Setting ZSH"
# mv .zshrc ~
wget https://raw.githubusercontent.com/OlivierProTips/linux_install/master/.zshrc -O ~/.zshrc

# UPLOAD
banner "Installing UPLOAD"
sudo wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/scripts/upload_file_wget.sh -O /usr/local/bin/upload_file_wget
sudo chmod +x /usr/local/bin/upload_file_wget

# MONIP
banner "Installing MONIP"
sudo wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/scripts/monip.sh -O /usr/local/bin/monip
sudo chmod +x /usr/local/bin/monip

# NMAPER
banner "Installing NMAPER"
sudo wget https://raw.githubusercontent.com/OlivierProTips/nmaper/master/nmaper.py -O /usr/local/bin/nmaper
sudo chmod +x /usr/local/bin/nmaper

# LESS
#
# banner "Installing LESS"
#
# chmod +x less.sh
# mv less.sh $(xdg-user-dir DESKTOP)

# BURPSUITE
if [[ ${arch} == "arm64" ]]
then

    banner "Installing BURPSUITE"

    sudo wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/scripts/burpsuite -O /usr/local/bin/burpsuite
    sudo chmod +x /usr/local/bin/burpsuite
    sudo /usr/local/bin/burpsuite -u
fi

# VPNCHOICE
banner "Installing VPNCHOICE"
sudo wget https://raw.githubusercontent.com/OlivierProTips/HackNotes/main/scripts/vpnchoice.py -O /usr/local/bin/vpnchoice
sudo chmod +x /usr/local/bin/vpnchoice
echo "alias vpnchoice='sudo vpnchoice'" >> ~/.zshrc
sudo python3 -m pip install simple-term-menu

# TOOLS
banner "Installing TOOLS"
mkdir ~/Tools
# echo '#!/bin/bash' > ~/Tools/update_tools.sh
# echo 'wget https://raw.githubusercontent.com/pentestmonkey/php-reverse-shell/master/php-reverse-shell.php -O ~/Tools/rev.php' >> ~/Tools/update_tools.sh
# echo 'wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh -O ~/Tools/linpeas.sh' >> ~/Tools/update_tools.sh
# echo 'wget https://github.com/DominicBreuker/pspy/releases/latest/download/pspy64 -O ~/Tools/pspy64' >> ~/Tools/update_tools.sh
# echo 'wget https://github.com/DominicBreuker/pspy/releases/latest/download/pspy32 -O ~/Tools/pspy32' >> ~/Tools/update_tools.sh
# chmod +x ~/Tools/update_tools.sh
# ~/Tools/update_tools.sh
cd ~/Tools/
wget https://raw.githubusercontent.com/ThePorgs/Exegol-resources/main/update-resources.sh -O update-resources.sh
chmod +x update-resources.sh
./update-resources.sh
cd ${currentDir}

# RESIZER
if [[ "$(systemd-detect-virt | awk '{print tolower($0)}')" =~ (qemu|vmware) ]]
then

    banner "Installing RESIZER on UTM"

    echo 'xrandr -s 1280x768' > $(xdg-user-dir DESKTOP)/medium.sh
    echo 'xrandr -s 1920x1080' > $(xdg-user-dir DESKTOP)/high.sh
    echo 'xrandr --output Virtual-1 --auto' > $(xdg-user-dir DESKTOP)/auto.sh
    chmod +x $(xdg-user-dir DESKTOP)/*.sh
fi

# TOOLS
banner "Installing DNSMASQ"
wget -O - https://raw.githubusercontent.com/OlivierProTips/linux_install/master/dnsmasq_install.sh | bash

# MANUAL STEPS
myTasks=(
    "Set Default application: Terminator"
    "Synchronize VSCode"
    "Synchronize Firefox"
    "Set time if needed"
    "BurpSuite Plugins:"
    "  HackVector"
    "  Turbo Intruder"
    "Install Notion"
)
listDisplay "MANUAL STEPS"

# TODO
# - [ ] tldr: install npm -> npm install -g tldr