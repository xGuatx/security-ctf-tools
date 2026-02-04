#!/bin/bash
# nikto_scan.sh - Web vulnerability scanner wrapper
# Usage: ./nikto_scan.sh URL

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ -z "$1" ]; then
    echo "Usage: $0 URL"
    exit 1
fi

URL="$1"
OUTPUT_FILE="${OUTPUT_DIR:-./results}/nikto_$(date +%Y%m%d_%H%M%S).txt"

echo "[*] Nikto scan on $URL"

if ! command -v nikto &> /dev/null; then
    echo "[!] Nikto not installed. Install with: sudo apt-get install nikto"
    exit 1
fi

nikto -h "$URL" -o "$OUTPUT_FILE" -Format txt

echo "[+] Scan complete. Results: $OUTPUT_FILE"
