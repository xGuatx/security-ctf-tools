#!/bin/bash
# ftp_anon.sh - Anonymous FTP checker
# Usage: ./ftp_anon.sh TARGET

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ -z "$1" ]; then
    echo "Usage: $0 TARGET"
    exit 1
fi

TARGET="$1"

echo "[*] Checking anonymous FTP on $TARGET"

# Try anonymous login
RESULT=$(timeout 10 ftp -n "$TARGET" 2>/dev/null <<EOF
user anonymous anonymous@test.com
pwd
ls
bye
EOF
)

if echo "$RESULT" | grep -qiE "230|logged in|directory"; then
    echo "[+] Anonymous FTP enabled!"
    echo "[*] Directory listing:"
    echo "$RESULT"
else
    echo "[-] Anonymous FTP not available"
fi
