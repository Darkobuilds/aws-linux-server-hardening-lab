#!/bin/bash
set -e
sudo apt update && sudo apt upgrade -y
sudo apt install -y nginx ufw fail2ban nmap tcpdump
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow OpenSSH
sudo ufw allow "Nginx Full"
sudo ufw --force enable
sudo ufw status verbose | tee ~/aws-linux-server-hardening-lab/audits/ufw_firewall_status.txt
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo sed -i "s/^#*PermitRootLogin.*/PermitRootLogin no/" /etc/ssh/sshd_config
sudo sed -i "s/^#*PasswordAuthentication.*/PasswordAuthentication no/" /etc/ssh/sshd_config
sudo sed -i "s/^#*MaxAuthTries.*/MaxAuthTries 3/" /etc/ssh/sshd_config
sudo systemctl restart ssh
echo "[+] Server hardening complete!"
