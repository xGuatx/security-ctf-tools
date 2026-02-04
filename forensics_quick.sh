#!/bin/bash
# forensics_quick.sh - Quick forensics analysis
# Usage: ./forensics_quick.sh FILE

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ -z "$1" ]; then
    echo "Usage: $0 FILE"
    exit 1
fi

FILE="$1"

echo "=========================================="
echo "      Quick Forensics Analysis           "
echo "=========================================="

echo -e "\n[*] File: $FILE"

# Basic file info
echo -e "\n[*] File type:"
file "$FILE"

# Hashes
echo -e "\n[*] Hashes:"
echo "MD5:    $(md5sum "$FILE" | cut -d' ' -f1)"
echo "SHA1:   $(sha1sum "$FILE" | cut -d' ' -f1)"
echo "SHA256: $(sha256sum "$FILE" | cut -d' ' -f1)"

# Hexdump header
echo -e "\n[*] File header (hex):"
xxd "$FILE" | head -5

# Strings (interesting)
echo -e "\n[*] Interesting strings:"
strings "$FILE" | grep -iE "http|ftp|pass|user|flag|ctf|key|admin|secret|base64" | head -20

# Embedded files
if command -v binwalk &> /dev/null; then
    echo -e "\n[*] Embedded files (binwalk):"
    binwalk "$FILE" | head -20
fi

echo -e "\n[*] Analysis complete"
