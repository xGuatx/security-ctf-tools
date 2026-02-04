#!/bin/bash
# subdomain_enum.sh - Subdomain enumeration
# Usage: ./subdomain_enum.sh DOMAIN

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ -z "$1" ]; then
    echo "Usage: $0 DOMAIN"
    exit 1
fi

DOMAIN="$1"
OUTPUT_FILE="${OUTPUT_DIR:-./results}/subdomains_${DOMAIN}_$(date +%Y%m%d_%H%M%S).txt"
WORDLIST="${WORDLIST_DIR:-./wordlists}/subdomains/common.txt"

echo "[*] Subdomain enumeration for $DOMAIN"

# Check if wordlist exists
if [ ! -f "$WORDLIST" ]; then
    echo "[!] Wordlist not found: $WORDLIST"
    echo "[*] Using basic enumeration with host command"
    
    # Basic common subdomains
    COMMON_SUBS="www mail ftp admin api dev staging test beta"
    for sub in $COMMON_SUBS; do
        result=$(host "${sub}.${DOMAIN}" 2>/dev/null | grep "has address")
        if [ -n "$result" ]; then
            echo "[+] Found: ${sub}.${DOMAIN}"
            echo "${sub}.${DOMAIN}" >> "$OUTPUT_FILE"
        fi
    done
else
    while read -r sub; do
        result=$(host "${sub}.${DOMAIN}" 2>/dev/null | grep "has address")
        if [ -n "$result" ]; then
            echo "[+] Found: ${sub}.${DOMAIN}"
            echo "${sub}.${DOMAIN}" >> "$OUTPUT_FILE"
        fi
    done < "$WORDLIST"
fi

echo "[*] Results saved to $OUTPUT_FILE"
