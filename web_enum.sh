#!/bin/bash
# web_enum.sh - Web application enumeration
# Usage: ./web_enum.sh URL

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ -z "$1" ]; then
    echo "Usage: $0 URL"
    exit 1
fi

URL="$1"
OUTPUT_FILE="${OUTPUT_DIR:-./results}/web_enum_$(date +%Y%m%d_%H%M%S).txt"

echo "[*] Web enumeration on $URL" | tee "$OUTPUT_FILE"
echo "=================================" | tee -a "$OUTPUT_FILE"

# HTTP Headers
echo -e "\n[*] HTTP Headers:" | tee -a "$OUTPUT_FILE"
curl -sI "$URL" | tee -a "$OUTPUT_FILE"

# Technologies
echo -e "\n[*] Checking common files:" | tee -a "$OUTPUT_FILE"
for file in robots.txt sitemap.xml .git/HEAD .env .htaccess; do
    status=$(curl -s -o /dev/null -w "%{http_code}" "$URL/$file")
    if [ "$status" = "200" ]; then
        echo "[+] Found: $URL/$file" | tee -a "$OUTPUT_FILE"
    fi
done

# Server info from headers
echo -e "\n[*] Server Technologies:" | tee -a "$OUTPUT_FILE"
curl -sI "$URL" | grep -iE "server|x-powered-by|x-aspnet|x-generator" | tee -a "$OUTPUT_FILE"

echo -e "\n[+] Enumeration complete. Results: $OUTPUT_FILE"
