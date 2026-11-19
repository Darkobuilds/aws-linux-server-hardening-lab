# Hardened Linux Web Server & Network Threat Monitoring Lab

## Overview
End-to-end provisioning, OS hardening, network port auditing, and automated threat detection on an Ubuntu Linux web server hosted on **AWS EC2**.

## Security Controls Implemented
- **AWS Network Perimeter:** Restricted inbound Security Group rules to SSH (Port 22 from admin IP only) and HTTP/HTTPS (Ports 80/443).
- **OS & SSH Hardening:** Disabled root login (`PermitRootLogin no`), enforced key-based authentication (`PasswordAuthentication no`), limited authentication retries (`MaxAuthTries 3`), and deployed **Fail2Ban**.
- **Host-Based Firewall:** Configured **UFW** with default-deny incoming and default-allow outgoing policies.
- **Network & Packet Auditing:** Verified exposed services via **Nmap** and inspected encrypted SSHv2 packet headers using **tcpdump/Wireshark**.
- **Automated Threat Detection:** Engineered **Bash** and **Python** log parsers scheduled via `cron` to monitor `/var/log/auth.log` for brute-force login attempts and `sudo` privilege escalations.

## Repository Structure
- `scripts/harden_server.sh` — Automated UFW, Fail2Ban, and OpenSSH hardening script.
- `scripts/auth_audit.sh` — Cron-scheduled Bash script summarizing authentication and privilege escalation events.
- `scripts/threat_detector.py` — Python log analyzer flagging brute-force threshold violations.
- `audits/` — Sanitized UFW status, Nmap scan results, packet inspection summaries, and Python alert outputs.
