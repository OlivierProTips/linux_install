# Ansible Playbooks

## Kali

```bash
sudo apt update && sudo apt install ansible -y
curl https://raw.githubusercontent.com/OlivierProTips/linux_install/kali/kali-setup.yml -o kali-setup.yml
ansible-playbook kali-setup.yml
```