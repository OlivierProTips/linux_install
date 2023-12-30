# linux_install

## kali_install.sh

This script will set up my environment from a fresh Kali installation.

```bash
git clone https://github.com/olivierprotips/linux_install
cd linux_install
./kali_install.sh
```

It will install the following:

- VSCode
- Terminator (+ config file)
- the rockyou list
- the seclists
- Feroxbuster
- Gobuster
- Pwncat-cs (in a python virtual env)
- Add vim config (allow to select text with mouse)
- .zshrc (Add IP in prompt)
- My upload script (upload file using python http server)
- My monip script (show your ip)
- My nmaper script (shortcut for nmap)
- My less script (map <> keys for Logi MX Keys on Parallels Desktop)
- Burpsuite if Kali ARM
- My vpnchoice script (allow to select your CTF vpn file)
- Some tools (and a script to update them)
  - php-reverse-shell.php
  - linpeas.sh
  - pspy64
  - pspy32
- My resizer scripts (for UTM and VMWARE)
- dnsmasq (using a separate script)

## dnsmasq_install

Install dnsmasq which is a small dns server. Useful for CTF, it replaces /etc/hosts and avoid adding every subdomains.

```bash
git clone https://github.com/olivierprotips/linux_install
cd linux_install
./dnsmasq_install.sh
```

## debian_install

This script will set up my environment from a fresh debian installation.

```bash
git clone https://github.com/olivierprotips/linux_install
cd linux_install
vi data
./debian_install.sh
```

It will install the following:

- git
- vim
- htop
- sudo
- wget
- nfs-common
- msmtp-mta
- bsd-mailx
- Add vim config (allow to select text with mouse)
- My check disk size script (+ crontab)
- My ll alias in .zshrc
- Set unattended update
