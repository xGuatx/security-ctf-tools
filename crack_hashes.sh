#!/bin/bash
# crack_hashes.sh - Hash cracking wrapper for John the Ripper
# Usage: ./crack_hashes.sh HASHFILE [WORDLIST]

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ -z "$1" ]; then
    echo "Usage: $0 HASHFILE [WORDLIST]"
    exit 1
fi

HASHFILE="$1"
WORDLIST="${2:-/usr/share/wordlists/rockyou.txt}"

echo "[*] Hash cracking: $HASHFILE"

if ! command -v john &> /dev/null; then
    echo "[!] John not installed. Install with: sudo apt-get install john"
    exit 1
fi

# Detect hash type
echo "[*] Detecting hash format..."
john --list=unknown --stdin < "$HASHFILE" 2>/dev/null | head -5

# Crack
john --wordlist="$WORDLIST" "$HASHFILE"

# Show cracked
echo -e "\n[*] Cracked passwords:"
john --show "$HASHFILE"
