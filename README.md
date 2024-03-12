# Ansible Playbooks

## Kali

```bash
brew install ansible
brew install esolitos/ipa/sshpass
```

```bash
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i kali.ini kali-setup.yml -u kali -k -K
```