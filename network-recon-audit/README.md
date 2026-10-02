# Network Reconnaissance & Port Scanning Audit

Prepared for: Palla Venkata Mahesh
Date: 02 October 2026

## Scope
This package is designed for an authorized Kali Linux security lab.

## Important evidence rule
The pre-populated text files contain only ports/services actually verified in the controlled packaging environment. They are intentionally NOT represented as genuine Nmap output. For the final submission, execute `recon_audit.sh` on Kali against your authorized sandbox target and replace the preflight files with the genuine Nmap outputs.

## Kali execution
```bash
cd network-recon-audit
chmod +x recon_audit.sh
./recon_audit.sh <AUTHORIZED_TARGET_IP> <AUTHORIZED_NETWORK>
```

Example:
```bash
./recon_audit.sh 192.168.56.20 192.168.56.0/24
```

## Wireshark
Capture the authorized target traffic and save the real capture as:
`wireshark-captures/network-recon.pcapng`

Recommended filter:
`tcp.flags.syn == 1 && tcp.flags.ack == 0`

## Submission
The final PDF should contain genuine Nmap outputs and genuine Wireshark screenshots from the authorized lab.
