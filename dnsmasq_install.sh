#!/bin/bash

# Install dnsmasq
# sudo apt install dnsmasq -y

# Add dns=dnsmasq to /etc/NetworkManager/NetworkManager.conf
NetworkManager_file="/etc/NetworkManager/NetworkManager.conf"
dns_exist=$(grep "dns=" ${NetworkManager_file})
if [[ -n ${dns_exist} ]]
then
    sudo sed -i '/dns=/c dns=dnsmasq' ${NetworkManager_file}
else
    sudo sed -i '/\[main\]/a dns=dnsmasq' ${NetworkManager_file}
fi

# Uncomment conf-dir in /etc/dnsmasq.conf
# sudo sed -i '/conf-dir=\/etc\/dnsmasq.d\/,\*.conf/s/^#//g' /etc/dnsmasq.conf

# Create a personal conf file
cat <<'EOF' | sudo tee /etc/NetworkManager/dnsmasq.d/perso.conf
server=8.8.8.8

address=/.example.com/93.184.216.34
EOF

# Enable and start the service
# sudo systemctl enable dnsmasq --now
sudo systemctl restart NetworkManager