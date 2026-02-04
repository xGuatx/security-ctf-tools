#!/bin/bash
# privesc_check.sh - Linux privilege escalation checker
# Usage: ./privesc_check.sh

echo "=========================================="
echo "   Linux Privilege Escalation Checker    "
echo "=========================================="
echo ""

echo "[*] Current user: $(whoami)"
echo "[*] ID: $(id)"
echo ""

echo "[*] Checking SUID binaries..."
find / -perm -4000 -type f 2>/dev/null | head -20
echo ""

echo "[*] Checking writable /etc/passwd..."
if [ -w /etc/passwd ]; then
    echo "[+] /etc/passwd is WRITABLE!"
else
    echo "[-] /etc/passwd is not writable"
fi
echo ""

echo "[*] Checking sudo permissions..."
sudo -l 2>/dev/null || echo "[-] Cannot check sudo"
echo ""

echo "[*] Checking cron jobs..."
cat /etc/crontab 2>/dev/null
ls -la /etc/cron.* 2>/dev/null
echo ""

echo "[*] Checking for sensitive files..."
for f in /home/*/.ssh/id_rsa /root/.ssh/id_rsa /etc/shadow; do
    if [ -r "$f" ]; then
        echo "[+] Readable: $f"
    fi
done
echo ""

echo "[*] Checking kernel version..."
uname -a
echo ""

echo "[*] Checking capabilities..."
getcap -r / 2>/dev/null | head -10
echo ""

echo "[*] Scan complete"
