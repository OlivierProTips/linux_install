# Ansible Playbooks

## Kali

```bash
sudo apt update && sudo apt install ansible -y
curl https://raw.githubusercontent.com/OlivierProTips/linux_install/master/kali-setup.yml -o /tmp/kali-setup.yml
ansible-playbook /tmp/kali-setup.yml
```