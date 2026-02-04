#!/bin/bash
# dirb_scan.sh - Directory brute-forcing
# Usage: ./dirb_scan.sh URL [WORDLIST]

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ -z "$1" ]; then
    echo "Usage: $0 URL [WORDLIST]"
    exit 1
fi

URL="$1"
WORDLIST="${2:-/usr/share/wordlists/dirb/common.txt}"
OUTPUT_FILE="${OUTPUT_DIR:-./results}/dirb_$(date +%Y%m%d_%H%M%S).txt"

echo "[*] Directory brute-force on $URL"
echo "[*] Wordlist: $WORDLIST"

# Try gobuster first, fall back to dirb
if command -v gobuster &> /dev/null; then
    gobuster dir -u "$URL" -w "$WORDLIST" -o "$OUTPUT_FILE" -t "${THREADS:-10}"
elif command -v dirb &> /dev/null; then
    dirb "$URL" "$WORDLIST" -o "$OUTPUT_FILE"
else
    echo "[!] Neither gobuster nor dirb found. Install with:"
    echo "    sudo apt-get install dirb gobuster"
    exit 1
fi

echo "[+] Scan complete. Results: $OUTPUT_FILE"
