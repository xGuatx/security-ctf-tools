#!/bin/bash
# decode_base64.sh - Base64 decoder
# Usage: ./decode_base64.sh INPUT

if [ -z "$1" ]; then
    echo "Usage: $0 INPUT_FILE_OR_STRING"
    exit 1
fi

INPUT="$1"

if [ -f "$INPUT" ]; then
    echo "[*] Decoding file: $INPUT"
    base64 -d "$INPUT"
else
    echo "[*] Decoding string..."
    echo "$INPUT" | base64 -d
fi
echo ""
