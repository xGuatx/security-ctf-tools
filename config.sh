#!/bin/bash
# config.sh - Global configuration for CTF tools
# Source this file in other scripts: source config.sh

THREADS=10
TIMEOUT=30
USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
OUTPUT_DIR="./results"
VERBOSE=true
WORDLIST_DIR="./wordlists"

# Create output directory if not exists
mkdir -p "$OUTPUT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
