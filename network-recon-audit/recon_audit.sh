#!/bin/bash
set -euo pipefail

TARGET="${1:-}"
NETWORK="${2:-}"

if [[ -z "$TARGET" ]]; then
  echo "Usage: ./recon_audit.sh <AUTHORIZED_TARGET_IP> [AUTHORIZED_NETWORK]"
  echo "Example: ./recon_audit.sh 192.168.56.20 192.168.56.0/24"
  exit 1
fi

mkdir -p nmap-results wireshark-captures screenshots report

echo "[1/7] TCP SYN scan..."
sudo nmap -sS "$TARGET" -oN nmap-results/tcp-syn.txt

echo "[2/7] All TCP ports..."
sudo nmap -sS -p- "$TARGET" -oN nmap-results/all-tcp-ports.txt

echo "[3/7] Service/version detection..."
sudo nmap -sV "$TARGET" -oN nmap-results/service-version.txt

echo "[4/7] OS detection..."
sudo nmap -O "$TARGET" -oN nmap-results/os-detection.txt

echo "[5/7] UDP top-ports scan..."
sudo nmap -sU --top-ports 20 "$TARGET" -oN nmap-results/udp-scan.txt

if [[ -n "$NETWORK" ]]; then
  echo "[6/7] Authorized host discovery..."
  sudo nmap -sn "$NETWORK" -oN nmap-results/host-discovery.txt
else
  echo "[6/7] Host discovery skipped because no authorized network was supplied."
  printf '%s\n' \
    'Host discovery skipped.' \
    'Run: sudo nmap -sn <AUTHORIZED_NETWORK> -oN nmap-results/host-discovery.txt' \
    > nmap-results/host-discovery.txt
fi

echo "[7/7] Combined scan..."
sudo nmap -sS -sV -O "$TARGET" -oN nmap-results/complete-scan.txt

echo
echo "Nmap collection complete."
echo "Start Wireshark and capture the authorized target interface."
echo "Save the capture as:"
echo "  wireshark-captures/network-recon.pcapng"
echo
echo "Recommended Wireshark filters:"
echo "  tcp.flags.syn == 1 && tcp.flags.ack == 0"
echo "  http"
echo "  ftp"
echo "  telnet"
echo "  dns"
