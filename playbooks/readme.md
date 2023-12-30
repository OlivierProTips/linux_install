# Ansible Playbooks

## Kali

```bash
brew install ansible
brew install esolitos/ipa/sshpass
ansible-playbook -i kali.ini kali-setup.yml -u kali -k -K
```