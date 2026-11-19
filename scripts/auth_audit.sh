#!/bin/bash
LOG_FILE="/var/log/auth.log"
REPORT_FILE="$HOME/aws-linux-server-hardening-lab/audits/security_audit_summary.txt"
echo "=== Security Audit Report: $(date -u) ===" > "$REPORT_FILE"
echo "[*] Verified Public-Key Logins:" >> "$REPORT_FILE"
grep "Accepted publickey" "$LOG_FILE" | tail -n 5 >> "$REPORT_FILE" || true
echo "[*] Failed/Closed SSH Attempts:" >> "$REPORT_FILE"
grep -E "Failed password|Invalid user|Connection closed" "$LOG_FILE" | tail -n 10 >> "$REPORT_FILE" || true
echo "[*] Sudo Privilege Escalation Events:" >> "$REPORT_FILE"
grep "sudo:" "$LOG_FILE" | tail -n 10 >> "$REPORT_FILE" || true
echo "----------------------------------------" >> "$REPORT_FILE"
