#!/bin/bash
# nmap_scan.sh - Automated Nmap scanning wrapper
# Usage: ./nmap_scan.sh TARGET [--quick|--full|--stealth]

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ -z "$1" ]; then
    echo "Usage: $0 TARGET [--quick|--full|--stealth]"
    echo "  TARGET: IP address or hostname"
    echo "  --quick: Fast scan (top 100 ports)"
    echo "  --full: Full port scan with service detection"
    echo "  --stealth: SYN stealth scan (requires root)"
    exit 1
fi

TARGET="$1"
MODE="${2:---quick}"
OUTPUT_FILE="${OUTPUT_DIR:-./results}/nmap_$(echo $TARGET | tr '/' '_')_$(date +%Y%m%d_%H%M%S).txt"

echo "[*] Nmap scan starting on $TARGET"
echo "[*] Mode: $MODE"
echo "[*] Output: $OUTPUT_FILE"

case "$MODE" in
    --quick)
        nmap -T4 --top-ports 100 -oN "$OUTPUT_FILE" "$TARGET"
        ;;
    --full)
        nmap -sV -sC -p- -T4 -oN "$OUTPUT_FILE" "$TARGET"
        ;;
    --stealth)
        sudo nmap -sS -T4 -p- -oN "$OUTPUT_FILE" "$TARGET"
        ;;
    *)
        nmap -T4 --top-ports 100 -oN "$OUTPUT_FILE" "$TARGET"
        ;;
esac

echo "[+] Scan complete. Results saved to $OUTPUT_FILE"
