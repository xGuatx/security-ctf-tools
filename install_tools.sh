#!/bin/bash
# install_tools.sh - Install required security tools
# Usage: ./install_tools.sh

echo "=========================================="
echo "   Security Tools Installer              "
echo "=========================================="

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "[!] Please run as root: sudo ./install_tools.sh"
    exit 1
fi

echo "[*] Updating package lists..."
apt-get update

echo -e "\n[*] Installing core tools..."
apt-get install -y \
    nmap \
    nikto \
    sqlmap \
    john \
    hydra \
    dirb \
    gobuster \
    smbclient \
    ftp \
    curl \
    wget \
    netcat-openbsd

echo -e "\n[*] Installing forensics tools..."
apt-get install -y \
    binwalk \
    exiftool \
    steghide \
    foremost

echo -e "\n[*] Installing Python dependencies..."
pip3 install requests aiohttp

echo -e "\n[*] Making scripts executable..."
chmod +x "$(dirname "$0")"/*.sh

echo -e "\n[*] Creating directories..."
mkdir -p ./results
mkdir -p ./wordlists/{passwords,usernames,directories,subdomains}

echo -e "\n[+] Installation complete!"
echo "[*] Consider also installing: metasploit-framework, wafw00f"
