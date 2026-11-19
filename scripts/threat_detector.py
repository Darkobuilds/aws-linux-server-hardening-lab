import re
from collections import Counter
from datetime import datetime, timezone

LOG_PATH = "/var/log/auth.log"
THRESHOLD = 3

def analyze_auth_logs(log_path):
    failed_ips = Counter()
    sudo_events = []
    with open(log_path, "r", encoding="utf-8", errors="ignore") as f:
        for line in f:
            if any(k in line for k in ("Failed password", "Invalid user", "Disconnected from invalid user")):
                ip_match = re.search(r"(\d+\.\d+\.\d+\.\d+)", line)
                if ip_match:
                    failed_ips[ip_match.group(1)] += 1
            if "sudo:" in line and "COMMAND=" in line:
                sudo_events.append(line.strip())
    print(f"[{datetime.now(timezone.utc).isoformat()}] Threat Monitoring Summary")
    if not failed_ips:
        print("[OK] Zero brute-force threshold breaches detected.")
    for ip, count in failed_ips.items():
        status = "ALERT" if count >= THRESHOLD else "WARN"
        print(f"[{status}] {count} failed authentication event(s) from IP: {ip}")
    print(f"[INFO] Total privileged sudo executions logged: {len(sudo_events)}")

if __name__ == "__main__":
    analyze_auth_logs(LOG_PATH)
