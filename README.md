# Security & CTF Tools

Collection of penetration testing and Capture The Flag (CTF) tools and scripts for security research and competitions.

## Description

Curated toolkit for ethical hacking, CTF challenges, penetration testing, and security research. Includes reconnaissance, exploitation, and post-exploitation utilities.

## Prerequisites

- Linux system (Kali Linux recommended)
- Python 3.x
- Various security tools (listed below)
- **Authorization** for target systems

## Installation

```bash
# Make all scripts executable
chmod +x *.sh

# Install dependencies
./install_tools.sh

# Or manual install
sudo apt-get install nmap nikto sqlmap john hydra metasploit-framework
```

## LEGAL DISCLAIMER

```
CRITICAL: This toolkit is for AUTHORIZED SECURITY TESTING ONLY.

AUTHORIZED USE:
- CTF competitions
- Bug bounty programs (within scope)
- Penetration tests with written permission
- Your own systems/networks
- Educational labs

UNAUTHORIZED USE IS ILLEGAL:
- Scanning/testing systems without permission
- Accessing systems you don't own
- Denial of service attacks
- Malicious hacking
- Privacy violations

UNAUTHORIZED USE IS A CRIME in most jurisdictions.
Always obtain written permission before testing any system.
```

## Tool Categories

### Reconnaissance

#### Network Scanning
- `nmap_scan.sh` - Automated Nmap scans
- `subdomain_enum.sh` - Subdomain enumeration
- `port_scan.sh` - Quick port scanner
- `service_detect.sh` - Service version detection

#### Web Recon
- `web_enum.sh` - Web application enumeration
- `nikto_scan.sh` - Web vulnerability scanner
- `dirb_scan.sh` - Directory brute-forcing
- `waf_detect.sh` - WAF detection

### Exploitation

#### Web Exploitation
- `sql_inject.sh` - SQL injection testing (sqlmap wrapper)
- `xss_test.sh` - XSS vulnerability testing
- `lfi_test.sh` - Local File Inclusion testing
- `rce_test.sh` - Remote Code Execution testing

#### Network Exploitation
- `smb_exploit.sh` - SMB vulnerability testing
- `ssh_bruteforce.sh` - SSH brute-force (hydra wrapper)
- `ftp_anon.sh` - Anonymous FTP checker

### Post-Exploitation

- `privesc_check.sh` - Linux privilege escalation checker
- `enum_linux.sh` - Linux enumeration script
- `crack_hashes.sh` - Hash cracking (john wrapper)
- `extract_creds.sh` - Credential extraction

### CTF Utilities

- `decode_base64.sh` - Base64 decoder
- `crack_cipher.sh` - Cipher cracking utilities
- `stego_extract.sh` - Steganography extraction
- `forensics_quick.sh` - Quick forensics analysis

## Usage Examples

### Reconnaissance

```bash
# Full network scan
./nmap_scan.sh 192.168.1.0/24

# Web application scan
./web_enum.sh https://target.com

# Subdomain enumeration
./subdomain_enum.sh target.com
```

### Exploitation

```bash
# SQL injection test
./sql_inject.sh https://target.com/page?id=1

# Directory bruteforce
./dirb_scan.sh https://target.com

# SSH brute-force (authorized only!)
./ssh_bruteforce.sh target.com username /path/to/wordlist.txt
```

### CTF Challenges

```bash
# Decode encoded data
./decode_base64.sh encoded.txt

# Extract hidden data from image
./stego_extract.sh image.png

# Crack hash
./crack_hashes.sh hash.txt /usr/share/wordlists/rockyou.txt
```

## Scripts Overview

### nmap_scan.sh
Automated Nmap scanning with multiple scan types.

```bash
# Quick scan
./nmap_scan.sh 192.168.1.100 --quick

# Full scan
./nmap_scan.sh 192.168.1.100 --full

# Stealth scan
./nmap_scan.sh 192.168.1.100 --stealth
```

### sql_inject.sh
SQL injection testing wrapper for sqlmap.

```bash
# Test URL for SQL injection
./sql_inject.sh "http://target.com/page?id=1"

# With authentication
./sql_inject.sh "http://target.com/page?id=1" --cookie="session=abc123"

# Dump database
./sql_inject.sh "http://target.com/page?id=1" --dump
```

### privesc_check.sh
Linux privilege escalation enumeration.

```bash
# Run all checks
./privesc_check.sh

# Output to file
./privesc_check.sh > privesc_report.txt
```

Checks:
- SUID binaries
- Writable /etc/passwd
- Sudo permissions
- Cron jobs
- Kernel exploits
- Capabilities

## Wordlists

### Included Wordlists

```
wordlists/
|---- passwords/
|   |---- common.txt
|   |---- top1000.txt
|   \---- rockyou.txt (symlink)
|---- usernames/
|   |---- common-usernames.txt
|   \---- admin-names.txt
|---- directories/
|   |---- common.txt
|   |---- php.txt
|   \---- api.txt
\---- subdomains/
    |---- common.txt
    \---- extensive.txt
```

### SecLists Integration

```bash
# Clone SecLists
git clone https://github.com/danielmiessler/SecLists.git

# Link to wordlists
ln -s SecLists/Passwords/Common-Credentials wordlists/passwords/
ln -s SecLists/Discovery/Web-Content wordlists/directories/
```

## Configuration

### config.sh

Global configuration:
```bash
# config.sh
THREADS=10
TIMEOUT=30
USER_AGENT="Mozilla/5.0"
OUTPUT_DIR="./results"
VERBOSE=true
```

Load in scripts:
```bash
source config.sh
```

## Automation

### CTF Challenge Solver

```bash
#!/bin/bash
# auto_solve.sh - Automated CTF challenge workflow

# 1. Recon
./port_scan.sh $TARGET
./web_enum.sh http://$TARGET

# 2. Common vulnerabilities
./sql_inject.sh http://$TARGET/login
./lfi_test.sh http://$TARGET/page?file=

# 3. Brute force
./dirb_scan.sh http://$TARGET
```

## Best Practices

### Testing Methodology

1. **Reconnaissance**
   - Passive recon first
   - Active scanning with permission
   - Document all findings

2. **Exploitation**
   - Test in isolated environment first
   - Start with least invasive techniques
   - Document proof of concept

3. **Reporting**
   - Clear vulnerability description
   - Steps to reproduce
   - Impact assessment
   - Remediation recommendations

### Operational Security

```bash
# Use VPN
sudo openvpn /path/to/config.ovpn

# Use Tor for anonymity (when appropriate)
torify ./tool.sh

# Clear logs
./clear_logs.sh
```

## Common CTF Categories

### Web
- SQL Injection
- XSS (Reflected/Stored)
- CSRF
- LFI/RFI
- Command Injection
- Authentication bypass

### Binary Exploitation
- Buffer overflow
- Format string
- Return-oriented programming (ROP)
- Heap exploitation

### Cryptography
- Classical ciphers (Caesar, Vigenere)
- Modern ciphers (RSA, AES)
- Hash functions
- Encoding (Base64, Hex)

### Forensics
- File carving
- Memory analysis
- Network packet analysis
- Steganography

### Reverse Engineering
- Binary analysis
- Decompilation
- Anti-debugging
- Obfuscation

## Resources

### Learning Platforms
- [HackTheBox](https://www.hackthebox.com/)
- [TryHackMe](https://tryhackme.com/)
- [PicoCTF](https://picoctf.org/)
- [OverTheWire](https://overthewire.org/)

### Tools Documentation
- [OWASP Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)
- [Nmap Reference](https://nmap.org/book/)
- [Metasploit Unleashed](https://www.offensive-security.com/metasploit-unleashed/)
- [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings)

### Cheat Sheets
- [PentestMonkey](http://pentestmonkey.net/)
- [GTFOBins](https://gtfobins.github.io/)
- [HackTricks](https://book.hacktricks.xyz/)

## Troubleshooting

### Permission Denied
```bash
# Run with sudo if needed
sudo ./script.sh

# Check file permissions
chmod +x script.sh
```

### Tool Not Found
```bash
# Install missing tool
sudo apt-get install tool-name

# Or run installer
./install_tools.sh
```

### Rate Limiting / WAF
```bash
# Slow down scans
./scan.sh --threads 1 --delay 1000

# Randomize user agent
./scan.sh --random-agent
```

## License

Personal project - Authorized testing only

---

**FINAL WARNING**:

```
UNAUTHORIZED COMPUTER ACCESS IS A CRIME 

18 U.S.C. Section 1030 (Computer Fraud and Abuse Act)
Similar laws exist worldwide.

Maximum penalties:
- Felony charges
- Prison time
- Heavy fines
- Permanent criminal record

ONLY use these tools:
[x] On systems you own
[x] With written authorization
[x] In legal CTF/lab environments
[x] Within bug bounty program scope

When in doubt, DON'T.
Get permission first. ALWAYS.
```

This toolkit is for educational and authorized security testing purposes only.
