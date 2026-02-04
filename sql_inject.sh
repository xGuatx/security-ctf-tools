#!/bin/bash
# sql_inject.sh - SQL injection testing wrapper
# Usage: ./sql_inject.sh URL [OPTIONS]

source "$(dirname "$0")/config.sh" 2>/dev/null || true

if [ -z "$1" ]; then
    echo "Usage: $0 URL [--cookie=COOKIE] [--dump]"
    exit 1
fi

URL="$1"
shift

echo "[*] SQL Injection testing on $URL"

if ! command -v sqlmap &> /dev/null; then
    echo "[!] sqlmap not installed. Install with: sudo apt-get install sqlmap"
    exit 1
fi

# Build sqlmap command
CMD="sqlmap -u \"$URL\" --batch --random-agent"

for arg in "$@"; do
    case "$arg" in
        --cookie=*)
            CMD="$CMD --cookie=\"${arg#*=}\""
            ;;
        --dump)
            CMD="$CMD --dump"
            ;;
        --dbs)
            CMD="$CMD --dbs"
            ;;
    esac
done

echo "[*] Running: $CMD"
eval $CMD
