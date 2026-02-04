#!/bin/bash
# enum_linux.sh - Linux enumeration script
# Usage: ./enum_linux.sh

echo "=========================================="
echo "      Linux Enumeration Script           "
echo "=========================================="

echo -e "\n[*] System Information"
echo "Hostname: $(hostname)"
echo "Kernel: $(uname -r)"
echo "OS: $(cat /etc/os-release 2>/dev/null | grep PRETTY_NAME | cut -d'"' -f2)"

echo -e "\n[*] Network Information"
ip addr 2>/dev/null || ifconfig
echo ""
ip route 2>/dev/null || route

echo -e "\n[*] Users"
cat /etc/passwd | grep -v nologin | grep -v false

echo -e "\n[*] Groups"
cat /etc/group

echo -e "\n[*] Running Processes"
ps aux --forest 2>/dev/null || ps aux

echo -e "\n[*] Listening Ports"
ss -tulpn 2>/dev/null || netstat -tulpn

echo -e "\n[*] Installed Packages (last 20)"
dpkg -l 2>/dev/null | tail -20 || rpm -qa 2>/dev/null | tail -20

echo -e "\n[*] Environment Variables"
env

echo -e "\n[*] Enumeration complete"
