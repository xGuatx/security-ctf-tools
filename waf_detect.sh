#!/bin/bash
# waf_detect.sh - WAF detection
# Usage: ./waf_detect.sh URL

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ -z "$1" ]; then
    echo "Usage: $0 URL"
    exit 1
fi

URL="$1"

echo "[*] WAF detection on $URL"

# Check using wafw00f if available
if command -v wafw00f &> /dev/null; then
    wafw00f "$URL"
else
    echo "[*] wafw00f not found, using manual detection"
    
    # Manual WAF detection via headers and response
    RESPONSE=$(curl -s -I "$URL")
    
    # Common WAF headers
    echo "$RESPONSE" | grep -iE "x-sucuri|x-cdn|cf-ray|x-akamai|x-firewall|x-waf" && echo "[+] WAF detected via headers"
    
    # Test with malicious payload
    TEST_PAYLOAD="<script>alert(1)</script>"
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "${URL}?test=${TEST_PAYLOAD}")
    
    if [ "$STATUS" = "403" ] || [ "$STATUS" = "406" ]; then
        echo "[+] Possible WAF detected (blocked test payload)"
    else
        echo "[-] No WAF detected (or WAF not blocking)"
    fi
fi
