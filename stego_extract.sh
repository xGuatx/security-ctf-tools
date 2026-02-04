#!/bin/bash
# stego_extract.sh - Steganography extraction
# Usage: ./stego_extract.sh IMAGE

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ -z "$1" ]; then
    echo "Usage: $0 IMAGE_FILE"
    exit 1
fi

IMAGE="$1"
OUTPUT_DIR="${OUTPUT_DIR:-./results}/stego_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTPUT_DIR"

echo "[*] Steganography extraction on $IMAGE"

# File info
echo -e "\n[*] File information:"
file "$IMAGE"

# Strings
echo -e "\n[*] Extracting strings..."
strings "$IMAGE" | grep -iE "flag|ctf|key|pass|secret" | head -20

# Exiftool
if command -v exiftool &> /dev/null; then
    echo -e "\n[*] EXIF metadata:"
    exiftool "$IMAGE"
fi

# Binwalk
if command -v binwalk &> /dev/null; then
    echo -e "\n[*] Binwalk analysis:"
    binwalk "$IMAGE"
    binwalk -e "$IMAGE" -C "$OUTPUT_DIR" 2>/dev/null
fi

# Steghide
if command -v steghide &> /dev/null; then
    echo -e "\n[*] Attempting steghide extract (blank password):"
    steghide extract -sf "$IMAGE" -p "" -xf "$OUTPUT_DIR/steghide_output" 2>/dev/null && echo "[+] Extracted!" || echo "[-] No data or wrong password"
fi

# Zsteg (for PNG)
if command -v zsteg &> /dev/null && [[ "$IMAGE" == *.png ]]; then
    echo -e "\n[*] Zsteg analysis:"
    zsteg "$IMAGE" 2>/dev/null | head -20
fi

echo -e "\n[*] Results saved to $OUTPUT_DIR"
