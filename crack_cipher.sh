#!/bin/bash
# crack_cipher.sh - Classical cipher cracking
# Usage: ./crack_cipher.sh TEXT [TYPE]

INPUT="$1"
TYPE="${2:-auto}"

if [ -z "$INPUT" ]; then
    echo "Usage: $0 TEXT [caesar|rot13|vigenere|auto]"
    exit 1
fi

echo "[*] Cipher cracking: $INPUT"

# ROT13
rot13() {
    echo "$1" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

# Caesar brute force
caesar_brute() {
    for i in {1..25}; do
        result=$(echo "$1" | tr "A-Za-z" "$(printf '%s' {A..Z} | head -c $i)$(printf '%s' {A..Z} | tail -c +$((i+1)))$(printf '%s' {a..z} | head -c $i)$(printf '%s' {a..z} | tail -c +$((i+1)))")
        echo "ROT$i: $result"
    done
}

case "$TYPE" in
    rot13)
        echo "[*] ROT13:"
        rot13 "$INPUT"
        ;;
    caesar)
        echo "[*] Caesar brute force:"
        caesar_brute "$INPUT"
        ;;
    *)
        echo "[*] ROT13:"
        rot13 "$INPUT"
        echo ""
        echo "[*] All Caesar rotations:"
        for i in {1..25}; do
            echo "ROT$i: $(echo "$INPUT" | python3 -c "import sys; s=sys.stdin.read().strip(); print(''.join([chr((ord(c)-65+$i)%26+65) if c.isupper() else chr((ord(c)-97+$i)%26+97) if c.islower() else c for c in s]))")"
        done
        ;;
esac
