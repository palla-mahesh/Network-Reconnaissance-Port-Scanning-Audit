# Network-Reconnaissance-Port-Scanning-Audit

Network Reconnaissance & Port Scanning Audit

Task: Network Reconnaissance & Port Scanning Audit
Prepared By: Palla Venkata Mahesh
Date: 02 October 2026
Platform: Kali Linux
Primary Tools: Nmap and Wireshark
Assessment Type: Authorized Security Lab / Sandbox Assessment

1. Project Overview

This project implements an authorized Network Reconnaissance and Port Scanning Audit using Kali Linux. The objective is to identify exposed network services, determine service versions, perform operating-system fingerprinting, inspect UDP services, and analyze network packets generated during the assessment.

The project uses:

Nmap for host discovery, TCP port scanning, UDP scanning, service/version detection, and OS detection.

Wireshark for packet capture and network-traffic analysis.

Kali Linux as the security-testing platform.

An authorized target VM or sandbox host as the assessment target.

The project is intended for educational and authorized security-testing environments only.

2. Objectives

The main objectives of this task are:

Perform structured network reconnaissance against an authorized target.

Identify active hosts within an authorized laboratory network.

Discover open TCP ports using TCP SYN scanning.

Scan the complete TCP port range when permitted.

Identify running services and their versions.

Perform operating-system detection using Nmap.

Identify commonly exposed UDP services.

Capture network traffic generated during the assessment using Wireshark.

Analyze TCP SYN, SYN/ACK, RST, UDP, DNS, HTTP, FTP, Telnet, or other relevant traffic where present.

Identify potentially insecure or unencrypted protocols within the authorized lab.

Document exposed services and potential attack surfaces.

Produce a professional Network Reconnaissance Findings Report.

3. Ethical and Authorization Requirements

This project must be performed only against systems for which explicit authorization has been obtained.

Allowed targets

Examples include:

Your own computer.

Your own virtual machine.

A deliberately vulnerable security-training VM.

A university-provided security laboratory.

An isolated cybersecurity sandbox.

A system for which you have written authorization to perform security testing.

Do not scan

Do not use the commands in this project against:

Public websites without permission.

Random internet hosts.

Other people's computers.

University or company networks without authorization.

Public IP addresses that you do not control.

Accounts or systems belonging to another person.

The purpose of this project is security auditing and education, not unauthorized access.

4. Recommended Lab Architecture

A recommended isolated lab configuration is:

                    Kali Linux
                  Security Tester
                 192.168.56.10
                       |
                       |
              Host-Only / Lab Network
                       |
                       |
                       v
                Authorized Target
                  192.168.56.20
                       |
                +------+------+
                |             |
              HTTP           SSH
              80/tcp        22/tcp

The exact addresses and services will depend on your laboratory configuration.

Do not copy example IP addresses into your final report unless they are actually used in your lab.

5. Software Requirements

Operating System

Kali Linux is recommended because it provides Nmap, Wireshark, and other security-testing utilities.

Check the operating system:

cat /etc/os-release

Check the kernel:

uname -a

6. Verify Required Tools

Check Nmap

nmap --version

Expected output should identify the installed Nmap version.

Check Wireshark

wireshark --version

If Wireshark is not installed:

sudo apt update
sudo apt install wireshark

Verify:

wireshark --version

7. Project Directory Structure

The project uses the following structure:

network-recon-audit/
│
├── recon_audit.sh
├── README.md
│
├── nmap-results/
│   ├── tcp-syn.txt
│   ├── all-tcp-ports.txt
│   ├── service-version.txt
│   ├── os-detection.txt
│   ├── udp-scan.txt
│   ├── host-discovery.txt
│   └── complete-scan.txt
│
├── wireshark-captures/
│   ├── network-recon.pcapng
│   └── README.txt
│
├── screenshots/
│   ├── 01-ip-address.png
│   ├── 02-tcp-scan.png
│   ├── 03-service-detection.png
│   ├── 04-os-detection.png
│   ├── 05-udp-scan.png
│   ├── 06-wireshark-tcp.png
│   └── 07-wireshark-analysis.png
│
└── report/
    └── Network_Reconnaissance_Findings_Report.pdf

8. Phase 1 — Identify the Kali Linux Interface

First identify the IP address of the Kali machine.

ip addr

Alternative:

hostname -I

Record the relevant interface and IP address.

Example:

Interface: eth0
IP Address: 192.168.56.10
Network: 192.168.56.0/24

Use the actual values from your environment.

Save a screenshot as:

screenshots/01-ip-address.png

9. Phase 2 — Verify Target Connectivity

Before scanning, verify that the authorized target is reachable.

Example:

ping -c 4 <AUTHORIZED_TARGET_IP>

Example:

ping -c 4 192.168.56.20

A successful response indicates that the target is reachable.

If ICMP is disabled, lack of a ping response does not necessarily mean that the host is offline. Continue only when the target is known to be authorized.

10. Phase 3 — Host Discovery

If an entire authorized lab subnet is within scope, perform host discovery.

sudo nmap -sn <AUTHORIZED_NETWORK>

Example:

sudo nmap -sn 192.168.56.0/24

Save the output:

sudo nmap -sn 192.168.56.0/24 \
-oN nmap-results/host-discovery.txt

Purpose

Host discovery helps determine which systems are responding within the authorized network.

Evidence

Store the resulting output in:

nmap-results/host-discovery.txt

11. Phase 4 — TCP SYN Scan

The primary TCP reconnaissance technique for this task is a TCP SYN scan.

sudo nmap -sS <AUTHORIZED_TARGET_IP>

Example:

sudo nmap -sS 192.168.56.20

Save the output:

sudo nmap -sS 192.168.56.20 \
-oN nmap-results/tcp-syn.txt

Purpose

The scan identifies TCP ports that respond as open, closed, or filtered.

Typical output:

PORT     STATE     SERVICE
22/tcp   open      ssh
80/tcp   open      http

The actual values must come from your target.

Screenshot

Capture the terminal showing the genuine Nmap result and save it as:

screenshots/02-tcp-scan.png

12. Phase 5 — Full TCP Port Scan

To check the complete TCP port range:

sudo nmap -sS -p- <AUTHORIZED_TARGET_IP>

Example:

sudo nmap -sS -p- 192.168.56.20

Save the result:

sudo nmap -sS -p- 192.168.56.20 \
-oN nmap-results/all-tcp-ports.txt

The -p- option requests scanning of TCP ports 1 through 65535.

This scan can take longer than a default Nmap scan.

13. Phase 6 — Service and Version Detection

After identifying open ports, determine which services and versions are exposed.

sudo nmap -sV <AUTHORIZED_TARGET_IP>

Example:

sudo nmap -sV 192.168.56.20

Save:

sudo nmap -sV 192.168.56.20 \
-oN nmap-results/service-version.txt

Information to document

For each discovered service record:

Port

Protocol

State

Service

Version

Actual

TCP/UDP

Open

Actual service

Actual version

Do not manually invent service names or versions.

Screenshot

Save the genuine terminal output as:

screenshots/03-service-detection.png

14. Phase 7 — Operating System Detection

Run:

sudo nmap -O <AUTHORIZED_TARGET_IP>

Example:

sudo nmap -O 192.168.56.20

Save:

sudo nmap -O 192.168.56.20 \
-oN nmap-results/os-detection.txt

Important

Nmap OS detection is a fingerprinting estimate. It can be affected by:

Firewalls.

Network filtering.

Virtualization.

Limited open ports.

Network topology.

Therefore, report Nmap's result as an OS fingerprint/estimate, not as unquestionable proof.

Screenshot

Save the genuine result as:

screenshots/04-os-detection.png

15. Phase 8 — UDP Scan

Perform an authorized UDP scan using common top ports:

sudo nmap -sU --top-ports 20 <AUTHORIZED_TARGET_IP>

Example:

sudo nmap -sU --top-ports 20 192.168.56.20

Save:

sudo nmap -sU --top-ports 20 192.168.56.20 \
-oN nmap-results/udp-scan.txt

Possible states

Nmap may report:

open
closed
open|filtered
filtered

An open|filtered result means Nmap could not definitively distinguish an open service from filtering based on the responses received.

Screenshot

Save the actual Nmap terminal output as:

screenshots/05-udp-scan.png

16. Phase 9 — Combined Nmap Scan

For a consolidated assessment:

sudo nmap -sS -sV -O <AUTHORIZED_TARGET_IP>

Save:

sudo nmap -sS -sV -O <AUTHORIZED_TARGET_IP> \
-oN nmap-results/complete-scan.txt

This combines:

TCP SYN scanning.

Service/version detection.

OS fingerprinting.

17. Phase 10 — Start Wireshark

Start Wireshark:

sudo wireshark

Select the interface connected to your authorized lab network.

Possible interfaces include:

eth0
ens33
wlan0

Select the interface that carries the traffic to the target.

Start the capture.

18. Phase 11 — Capture Nmap Traffic

With Wireshark capturing, run an authorized TCP SYN scan from another terminal:

sudo nmap -sS <AUTHORIZED_TARGET_IP>

Observe the generated TCP traffic.

A typical SYN exchange may look conceptually like:

Kali                          Target
 |                              |
 | -------- SYN -------------> |
 |                              |
 | <------ SYN/ACK ----------- |
 |                              |
 | -------- RST -------------> |
 |                              |

The exact traffic depends on the target, firewall, service state, and scan behavior.

19. Wireshark TCP Filter

Use the following display filter:

tcp

For SYN packets:

tcp.flags.syn == 1

For initial SYN packets:

tcp.flags.syn == 1 && tcp.flags.ack == 0

This filter is useful for demonstrating the TCP SYN traffic generated during the scan.

Save a genuine screenshot as:

screenshots/06-wireshark-tcp.png

20. UDP Traffic Analysis

Run the authorized UDP scan while Wireshark is capturing:

sudo nmap -sU --top-ports 20 <AUTHORIZED_TARGET_IP>

Use:

udp

as the Wireshark display filter.

You can also examine ICMP responses:

icmp

UDP behavior varies depending on the target and network controls.

21. HTTP Traffic Analysis

If the authorized lab target actually provides HTTP traffic, use:

http

or:

http.request

This can show HTTP requests and responses.

HTTP is generally not encrypted at the protocol level, unlike HTTPS. If sensitive information is observed in the authorized lab, document the observation carefully.

Do not intercept credentials or sensitive traffic from unauthorized systems.

22. FTP Analysis

If FTP is intentionally enabled on the authorized target:

ftp

can be used as a Wireshark filter.

FTP is traditionally an unencrypted protocol, so the lab can demonstrate why encrypted alternatives and secure authentication are important.

Only perform this analysis in the authorized environment.

23. Telnet Analysis

If Telnet is present in the authorized lab:

telnet

can be used to isolate Telnet-related traffic.

Telnet is an insecure legacy protocol because it does not provide modern encrypted transport.

Document only what is observed in the authorized test environment.

24. DNS Analysis

For DNS traffic:

dns

You can examine:

DNS queries.

DNS responses.

Query types.

Response codes.

Requested domains within the authorized lab.

25. Save the Wireshark Capture

When the capture is complete:

Stop packet capture.

Select File → Save As.

Save as:

wireshark-captures/network-recon.pcapng

The .pcapng file is the primary packet-capture evidence.

Do not create fake packets or manually modify packet contents to manufacture findings.

26. Required Screenshots

The final project should contain original screenshots captured from Kali Linux.

Screenshot 01 — IP Address

screenshots/01-ip-address.png

Show:

ip addr

Screenshot 02 — TCP Scan

screenshots/02-tcp-scan.png

Show the genuine:

sudo nmap -sS <TARGET>

result.

Screenshot 03 — Service Detection

screenshots/03-service-detection.png

Show:

sudo nmap -sV <TARGET>

Screenshot 04 — OS Detection

screenshots/04-os-detection.png

Show:

sudo nmap -O <TARGET>

Screenshot 05 — UDP Scan

screenshots/05-udp-scan.png

Show:

sudo nmap -sU --top-ports 20 <TARGET>

Screenshot 06 — Wireshark TCP

screenshots/06-wireshark-tcp.png

Show Wireshark with:

tcp.flags.syn == 1 && tcp.flags.ack == 0

Screenshot 07 — Wireshark Analysis

screenshots/07-wireshark-analysis.png

Show relevant protocol analysis such as:

http
ftp
telnet
dns

Only include filters for protocols actually present in your capture.

27. Evidence Quality Requirements

For a professional submission:

Screenshots must be captured from your own authorized Kali lab.

Nmap result files must be generated by Nmap.

Wireshark screenshots must correspond to the submitted .pcapng.

IP addresses in the report must match the actual lab.

Port numbers must match the actual scan.

Service versions must match the actual Nmap output.

OS information must match the actual Nmap result.

Findings must be based on observed evidence.

Do not fabricate vulnerabilities.

Do not claim a service is vulnerable merely because a port is open.

28. Findings Documentation

Create a table based on the actual scan.

Recommended format:

Finding ID

Port

Service

Observation

Evidence

Security Consideration

F-01

Actual

Actual

Actual observed service

Nmap

Review exposure

F-02

Actual

Actual

Actual protocol

Nmap/Wireshark

Apply appropriate controls

F-03

Actual

Actual

Actual traffic observation

Wireshark

Review encryption/configuration

The table must contain your actual observations.

29. Attack Surface Documentation

The purpose of attack-surface documentation is to record what is exposed, not to exploit it.

Example categories:

Network Services

SSH

HTTP/HTTPS

DNS

FTP

SMB

Database services

Other services discovered by Nmap

Information Exposure

Service versions.

Operating-system fingerprint.

Network protocol information.

Unencrypted application traffic.

Configuration Considerations

Unnecessary services.

Broad network exposure.

Legacy protocols.

Weak segmentation.

Missing encryption.

30. Security Recommendations

Recommendations should be based on actual observations.

General recommendations may include:

Disable unnecessary services.

Restrict management services to trusted networks.

Apply security patches regularly.

Use host-based and network firewalls.

Prefer encrypted protocols.

Segment sensitive services.

Restrict database services from unnecessary network exposure.

Monitor unusual traffic.

Maintain an approved service inventory.

Periodically perform authorized network audits.

31. Running the Automated Script

The project includes:

recon_audit.sh

Make it executable:

chmod +x recon_audit.sh

Run:

./recon_audit.sh <AUTHORIZED_TARGET_IP> <AUTHORIZED_NETWORK>

Example:

./recon_audit.sh 192.168.56.20 192.168.56.0/24

The script performs:

TCP SYN Scan
       ↓
Full TCP Port Scan
       ↓
Service / Version Detection
       ↓
OS Detection
       ↓
UDP Scan
       ↓
Host Discovery
       ↓
Combined Scan

32. Generated Nmap Files

tcp-syn.txt

Contains the TCP SYN scan output.

Command:

sudo nmap -sS <TARGET> -oN nmap-results/tcp-syn.txt

all-tcp-ports.txt

Contains the full TCP port-range scan.

Command:

sudo nmap -sS -p- <TARGET> \
-oN nmap-results/all-tcp-ports.txt

service-version.txt

Contains service and version information.

Command:

sudo nmap -sV <TARGET> \
-oN nmap-results/service-version.txt

os-detection.txt

Contains Nmap OS fingerprinting results.

Command:

sudo nmap -O <TARGET> \
-oN nmap-results/os-detection.txt

udp-scan.txt

Contains UDP top-port scan results.

Command:

sudo nmap -sU --top-ports 20 <TARGET> \
-oN nmap-results/udp-scan.txt

host-discovery.txt

Contains authorized network host-discovery results.

Command:

sudo nmap -sn <AUTHORIZED_NETWORK> \
-oN nmap-results/host-discovery.txt

complete-scan.txt

Contains the combined scan.

Command:

sudo nmap -sS -sV -O <TARGET> \
-oN nmap-results/complete-scan.txt

33. Recommended Execution Order

Follow this order:

1. Confirm authorization
        ↓
2. Configure isolated lab
        ↓
3. Identify Kali IP
        ↓
4. Identify authorized target
        ↓
5. Verify connectivity
        ↓
6. Start Wireshark
        ↓
7. Host discovery
        ↓
8. TCP SYN scan
        ↓
9. Full TCP scan
        ↓
10. Service/version detection
        ↓
11. OS detection
        ↓
12. UDP scan
        ↓
13. Analyze packets
        ↓
14. Save PCAPNG
        ↓
15. Capture screenshots
        ↓
16. Document findings
        ↓
17. Prepare PDF report
        ↓
18. Review evidence
        ↓
19. Submit authorized deliverable

34. Final Validation Checklist

Before submitting, verify:

Nmap

TCP SYN scan completed.

Full TCP scan completed.

Service/version detection completed.

OS detection completed.

UDP scan completed.

Host discovery completed if a network was in scope.

All results were generated against the authorized target.

Wireshark

Correct network interface selected.

Nmap traffic captured.

TCP traffic reviewed.

UDP traffic reviewed where present.

Relevant application protocols reviewed.

Capture saved as .pcapng.

Screenshots correspond to the actual capture.

Documentation

Target IP documented.

Tester name documented.

Date documented.

Scope documented.

Open ports documented.

Services documented.

Findings documented.

Recommendations documented.

Screenshots inserted.

Nmap outputs included.

PDF report completed.

35. Final Deliverable

The completed submission should contain:

network-recon-audit/
│
├── recon_audit.sh
├── README.md
│
├── nmap-results/
│   ├── tcp-syn.txt
│   ├── all-tcp-ports.txt
│   ├── service-version.txt
│   ├── os-detection.txt
│   ├── udp-scan.txt
│   ├── host-discovery.txt
│   └── complete-scan.txt
│
├── wireshark-captures/
│   └── network-recon.pcapng
│
├── screenshots/
│   ├── 01-ip-address.png
│   ├── 02-tcp-scan.png
│   ├── 03-service-detection.png
│   ├── 04-os-detection.png
│   ├── 05-udp-scan.png
│   ├── 06-wireshark-tcp.png
│   └── 07-wireshark-analysis.png
│
└── report/
    └── Network_Reconnaissance_Findings_Report.pdf

36. Conclusion

The Network Reconnaissance & Port Scanning Audit demonstrates a structured approach to authorized network-security assessment. Nmap provides network discovery, port enumeration, service identification, and OS fingerprinting capabilities, while Wireshark provides packet-level visibility into the traffic generated during testing.

The combination of command output, packet captures, screenshots, findings, and recommendations creates an auditable security-assessment package. All final evidence should be generated from the authorized Kali Linux laboratory environment and should accurately reflect the target's actual configuration at the time of testing.

Prepared by: Palla Venkata Mahesh
Date: 02 October 2026
Project: Network Reconnaissance & Port Scanning Audit
