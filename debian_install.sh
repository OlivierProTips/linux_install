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
apt install git vim htop sudo wget nfs-common -y

banner "Install msmtp-mta bsd-mailx"
apt install msmtp-mta bsd-mailx -y

banner "Install unattended-upgrades apt-listchanges"
apt install unattended-upgrades apt-listchanges -y

# Copy msmtp config
# cp .msmtprc /home/$user
# chmod 600 /home/$user/.msmtprc
cp msmtprc /etc/msmtprc
chmod 644 /etc/msmtprc
sed -i "/from/s/ .*/ $MAILFROM/" /etc/msmtprc
sed -i "/user/s/ .*/ $MAILFROM/" /etc/msmtprc
sed -i "/password/s/ .*/ $MAILPASSWORD/" /etc/msmtprc
sed -i "/host/s/ .*/ $MAILHOST/" /etc/msmtprc

# Get check_disk_size.sh
mkdir /home/$user/scripts
wget https://gist.githubusercontent.com/OlivierProTips/ceb4e778e44a27a7739db008f6b2488d/raw/check_disk_size.sh -O /home/$user/scripts/check_disk_size.sh
chmod +x /home/$user/scripts/check_disk_size.sh

# Get aptcheck.sh
# mkdir /root/scripts
# wget https://gist.githubusercontent.com/OlivierProTips/7143d92877d1871e1367ff98e6905402/raw/aptcheck.sh -O /root/scripts/aptcheck.sh
# chmod u+x /root/scripts/aptcheck.sh

# Add user to sudoers
adduser $user sudo

# Configure VIM for user and root
banner "Setting VIM"
echo 'source $VIMRUNTIME/defaults.vim' >> /home/$user/.vimrc
echo 'set mouse-=a' >> /home/$user/.vimrc
echo 'source $VIMRUNTIME/defaults.vim' >> /root/.vimrc
echo 'set mouse-=a' >> /root/.vimrc

# Add check disk size to user cron
crontab -u $user -l | { cat; echo; echo "MAILTO=$MAILTO"; } | crontab -u $user -
crontab -u $user -l | { cat; echo "MAILFROM=$MAILFROM"; } | crontab -u $user -
crontab -u $user -l | { cat; echo; echo "# Check disk size"; } | crontab -u $user -
crontab -u $user -l | { cat; echo "0 */1 * * * /home/$user/scripts/check_disk_size.sh | mail -E -s \"[CRON][\$(hostname | tr a-z A-Z)] Low disk space\" \$MAILTO > /dev/null"; } | crontab -u $user -

# Add apt check to root cron
# crontab -l | { cat; echo; echo "MAILTO=$MAILTO"; } | crontab -
# crontab -l | { cat; echo "MAILFROM=$MAILFROM"; } | crontab -
# crontab -l | { cat; echo; echo "# Check if server can be updated"; } | crontab -
# crontab -l | { cat; echo "0 12 * * * /root/scripts/aptcheck.sh | mail -E -s \"[CRON][\$(hostname | tr a-z A-Z)] Update available\" \$MAILTO > /dev/null"; } | crontab -

# Add alias
echo "alias ll='ls -lah --color'" >> /home/$user/.bashrc
echo "alias ll='ls -lah --color'" >> /root/.bashrc

# Chown all user folder
chown -R $user:$user /home/$user

# Configure unattended
cp /usr/share/unattended-upgrades/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades
sed -i '/origin=Debian,codename=\${distro_codename}-updates/s/\/\///g' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::SyslogEnable/s/\/\///g' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Mail/s/\/\///' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i "/Unattended-Upgrade::Mail /s/\"\"/\"$MAILTO\"/" /etc/apt/apt.conf.d/50unattended-upgrades
sed -i "/email_address=/s/=.*/=$MAILTO/" /etc/apt/listchanges.conf

# MANUAL STEPS
myTasks=(
    "Check mail in"
    "  crontab (root and $user)"
    "  /etc/msmtprc"
    "  /etc/apt/listchanges.conf"
    "  /etc/apt/apt.conf.d/50unattended-upgrades"
)
listDisplay "MANUAL STEPS"

# reboot