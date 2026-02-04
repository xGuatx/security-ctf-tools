#!/bin/bash
# service_detect.sh - Service version detection
# Usage: ./service_detect.sh TARGET

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ -z "$1" ]; then
    echo "Usage: $0 TARGET"
    exit 1
fi

TARGET="$1"
OUTPUT_FILE="${OUTPUT_DIR:-./results}/services_${TARGET}_$(date +%Y%m%d_%H%M%S).txt"

echo "[*] Service detection on $TARGET"

nmap -sV -sC --version-intensity 5 -oN "$OUTPUT_FILE" "$TARGET"

echo "[+] Results saved to $OUTPUT_FILE"
