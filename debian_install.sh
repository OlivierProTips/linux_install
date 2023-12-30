#!/bin/bash
# DRAFTÒ

# Check if we are root
if [ "$EUID" -ne 0 ]
then
    echo "ERROR: Please run as root"
    exit 1
fi

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
echo "=============================="
echo "Install packages"
echo "=============================="
apt install git vim htop sudo wget nfs-common -y

echo "=============================="
echo "Install msmtp-mta bsd-mailx"
echo "=============================="
apt install msmtp-mta bsd-mailx -y

# Copy msmtp config
cp .msmtprc /home/$user
chmod 600 /home/$user/.msmtprc

# Get check_disk_size.sh
mkdir /home/$user/scripts
wget https://gist.githubusercontent.com/OlivierProTips/ceb4e778e44a27a7739db008f6b2488d/raw/check_disk_size.sh -O /home/$user/scripts/check_disk_size.sh
chmod +x /home/$user/scripts/check_disk_size.sh

# Add user to sudoers
adduser $user sudo

# Configure VIM for user and root
echo "=============================="
echo "Setting VIM"
echo "=============================="
echo 'source $VIMRUNTIME/defaults.vim' >> /home/$user/.vimrc
echo 'set mouse-=a' >> /home/$user/.vimrc
echo 'source $VIMRUNTIME/defaults.vim' >> /root/.vimrc
echo 'set mouse-=a' >> /root/.vimrc

# Add check disk size to cron
crontab -u $user -l | { cat; echo; echo "MAILTO=[MAIL]"; } | crontab -u $user -
crontab -u $user -l | { cat; echo "MAILFROM=[MAIL]"; } | crontab -u $user -
crontab -u $user -l | { cat; echo; echo "# Check disk size"; } | crontab -u $user -
crontab -u $user -l | { cat; echo "0 */1 * * * /home/$user/scripts/check_disk_size.sh"; } | crontab -u $user -

# Add alias
echo "alias ll='ls -lah --color'" >> /home/$user/.bashrc

# Chown all user folder
chown -R $user:$user /home/$user

# MANUAL STEPS
myTasks=(
    "Edit .msmtprc file"
    "Edit MAIL in crontab"
)
listDisplay "MANUAL STEPS"

# reboot