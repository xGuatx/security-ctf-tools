#!/bin/bash
# port_scan.sh - Quick port scanner
# Usage: ./port_scan.sh TARGET

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ -z "$1" ]; then
    echo "Usage: $0 TARGET [PORT_RANGE]"
    echo "  TARGET: IP or hostname"
    echo "  PORT_RANGE: e.g., 1-1000 (default: 1-1024)"
    exit 1
fi

TARGET="$1"
RANGE="${2:-1-1024}"
OUTPUT_FILE="${OUTPUT_DIR:-./results}/ports_${TARGET}_$(date +%Y%m%d_%H%M%S).txt"

echo "[*] Scanning $TARGET ports $RANGE"

# Use nmap if available, fallback to bash
if command -v nmap &> /dev/null; then
    nmap -p "$RANGE" --open -oG - "$TARGET" | grep "open" | tee "$OUTPUT_FILE"
else
    # Pure bash fallback (slower)
    START=$(echo $RANGE | cut -d'-' -f1)
    END=$(echo $RANGE | cut -d'-' -f2)
    
    for port in $(seq $START $END); do
        timeout 1 bash -c "echo >/dev/tcp/$TARGET/$port" 2>/dev/null && echo "[+] Port $port open" | tee -a "$OUTPUT_FILE"
    done
fi

echo "[*] Scan complete"
