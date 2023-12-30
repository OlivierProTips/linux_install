#!/bin/bash
# DRAFT
# su -
# apt install git -y
# git clone -b dev https://github.com/olivierprotips/linux_install


# Check if we are root
if [ "$EUID" -ne 0 ]
then
    echo "ERROR: Please run as root"
    exit 1
fi

source data

banner() {
    msg="| $* |"
    edge="+-$(echo "$*" | sed 's/./-/g')-+"
    echo "$edge"
    echo "$msg"
    echo "$edge"
}

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

# Retrieve username with uid 1000
user=$(cat /etc/passwd | grep 1000 | cut -d":" -f1)
if [[ -z $user ]]
then
    echo "ERROR: No user with uid 1000"
    exit 1
fi

# Update apt lists
DEBIAN_FRONTEND=noninteractive apt update
# sudo DEBIAN_FRONTEND=noninteractive apt dist-upgrade -y

# Install packages
banner "Install packages"
apt install git vim htop sudo wget nfs-common ncdu autofs -y

banner "Install msmtp-mta bsd-mailx"
apt install msmtp-mta bsd-mailx -y

# Copy msmtp config
cp msmtprc /etc/msmtprc
chmod 644 /etc/msmtprc
sed -i "/from/s/ .*/ $MAILFROM/" /etc/msmtprc
sed -i "/user/s/ .*/ $MAILFROM/" /etc/msmtprc
sed -i "/password/s/ .*/ $MAILPASSWORD/" /etc/msmtprc
sed -i "/host/s/ .*/ $MAILHOST/" /etc/msmtprc

# Add user to sudoers
adduser $user sudo

# VIM
banner "Setting VIM"
echo 'source $VIMRUNTIME/defaults.vim' >> ~/.vimrc
echo 'set mouse-=a' >> ~/.vimrc
echo 'source $VIMRUNTIME/defaults.vim' | sudo tee -a /root/.vimrc > /dev/null
echo 'set mouse-=a' | sudo tee -a /root/.vimrc > /dev/null

# Add alias
echo "alias ll='ls -lah --color'" >> /home/$user/.bashrc
echo "alias ll='ls -lah --color'" >> /root/.bashrc

# Chown all user folder
chown -R $user:$user /home/$user

# MANUAL STEPS
myTasks=(
    "Check mail in"
    "  crontab (root and $user)"
    "  /etc/msmtprc"
    # "  /etc/apt/listchanges.conf"
    # "  /etc/apt/apt.conf.d/50unattended-upgrades"
)
listDisplay "MANUAL STEPS"

# reboot