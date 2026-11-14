
# CleanCity Services Scheduling Server
## Penetration Testing and Hardening Project

---

## Project Information

| **Field** | **Details** |
|---|---|
| Project Name | Penetration Test and Hardening of CleanCity Services Scheduling Server |
| Client | CleanCity Services |
| Technology Domain | Cybersecurity |
| Project Level | Intermediate |
| Internship Task | Task 1 – Initial Reconnaissance |
| Intern | Hafiz Muhammad Moawiz |
| Target Hostname | ubunto |
| Target IP Address | 172.16.229.131 |
| Operating System | Ubuntu 22.04 LTS |

## 1. Project Overview

This project focuses on the security assessment and hardening of the CleanCity Services Scheduling Server.

The first phase involves establishing an isolated laboratory environment, deploying the Damn Vulnerable Web Application (DVWA), performing network reconnaissance, and identifying accessible web directories and files.

The assessment is performed using standard cybersecurity tools to understand the target system's initial attack surface.

## 2. Project Objectives

- Create an isolated Ubuntu 22.04 virtual machine.
- Install and configure DVWA.
- Identify the target system's IP address.
- Discover open ports and running services.
- Perform service detection using Nmap.
- Enumerate hidden web directories using Gobuster.
- Document reconnaissance findings.
- Maintain screenshots and command outputs as evidence.

## 3. Lab Environment

### 3.1 System Configuration

| **Component** | **Specification** |
|---|---|
| Host Operating System | Ubuntu |
| Virtualization Platform | VMware Workstation |
| Target Operating System | Ubuntu 22.04 LTS |
| Target Hostname | `ubunto` |
| Target IP | `172.16.229.131` |
| Web Server | Apache HTTP Server 2.4.52 |
| Database Server | MariaDB |
| Server-Side Language | PHP |
| Vulnerable Application | DVWA |

### 3.2 Tools Used

| **Tool** | **Version / Source** | **Purpose** |
|---|---|---|
| Nmap | 7.80 | Network and service scanning |
| Gobuster | 2.0.1 | Directory and file enumeration |
| DIRB Wordlist | Common | Wordlist for enumeration |
| Apache | 2.4.52 | Web server |
| MariaDB | Installed version | Database service |
| PHP | Installed version | DVWA application support |
| Git | Installed version | Downloading DVWA |

## 4. Task 1 – Initial Reconnaissance

The first task involved setting up the target environment and identifying the services and web resources exposed by the target system.

### 4.1 Virtual Machine Setup

- Installed Ubuntu 22.04 LTS.
- Configured the virtual machine.
- Created a VM snapshot.
- Updated system packages.

### 4.2 DVWA Installation

Installed the required dependencies:

- Apache HTTP Server
- MariaDB Database Server
- PHP and required extensions
- Git

Downloaded DVWA from its official repository and configured the application files and database.

Application URL:

`http://localhost/DVWA/`

### 4.3 Network Reconnaissance

Used Nmap to identify open ports and running services.

Command:

```bash
sudo nmap -sV -A 172.16.229.131 \
-oN reconnaissance/nmap/initial-scan.txt
```

### 4.4 Directory Enumeration

Used Gobuster with the DIRB common wordlist to discover web paths.

Command:

```bash
gobuster -m dir \
-u http://127.0.0.1/DVWA/ \
-w /usr/share/dirb/wordlists/common.txt \
-x php,txt,html \
-o reconnaissance/gobuster/dvwa-scan.txt
```

## 5. Initial Findings

### 5.1 Nmap Results

| **Port** | **State** | **Service** | **Version** |
|---|---|---|---|
| 80/tcp | Open | HTTP | Apache 2.4.52 (Ubuntu) |

### 5.2 Gobuster Results

The enumeration identified multiple web paths, including:

| **Path** | **HTTP Status** |
|---|---:|
| `/.git/HEAD` | 200 |
| `/about.php` | 200 |
| `/instructions.php` | 200 |
| `/login.php` | 200 |
| `/php.ini` | 200 |
| `/robots.txt` | 200 |
| `/security.txt` | 200 |
| `/setup.php` | 200 |
| `/config` | 301 |
| `/database` | 301 |
| `/docs` | 301 |
| `/external` | 301 |

These results represent initial enumeration observations. Further validation is required before identifying any security vulnerability.

## 6. Project Directory Structure

```text
CleanCity-Penetration-Testing/
│
├── lab/
│   └── scripts/
│       └── setup.sh
│
├── reconnaissance/
│   ├── nmap/
│   │   └── initial-scan.txt
│   │
│   ├── gobuster/
│   │   └── dvwa-scan.txt
│   │
│   └── initial-recon.md
│
├── vulnerability-assessment/
│   └── findings.md
│
├── hardening/
│   ├── evidence/
│   │   ├── before/
│   │   └── after/
│   │
│   └── hardening-checklist.md
│
├── reports/
│   └── final-report.md
│
└── screenshots/
    ├── 01 dvwa-setup/
    ├── 02 nmap/
    └── 03 directory-enumeration/
```

## 7. Evidence and Documentation

All practical activities are documented through screenshots and command outputs.

| **Evidence** | **Location** |
|---|---|
| DVWA Installation Screenshots | `screenshots/01 dvwa-setup/` |
| Nmap Screenshots | `screenshots/02 nmap/` |
| Gobuster Screenshots | `screenshots/03 directory-enumeration/` |
| Nmap Raw Output | `reconnaissance/nmap/` |
| Gobuster Raw Output | `reconnaissance/gobuster/` |
| Reconnaissance Report | `reconnaissance/initial-recon.md` |

## 8. Setup Instructions

For a fresh Ubuntu 22.04 environment:

### Run the Setup Script

```bash
chmod +x lab/scripts/setup.sh
./lab/scripts/setup.sh
```

After running the script, configure the DVWA database manually and complete the application setup through the browser.

## 9. Current Project Status

**Task 1 – Initial Reconnaissance**

- Virtual machine setup: Completed
- DVWA installation: Completed
- Nmap reconnaissance: Completed
- Gobuster enumeration: Completed
- Evidence collection: Completed
- Initial reconnaissance documentation: Completed

## 10. Conclusion

The initial reconnaissance phase established the laboratory environment and identified the target's exposed HTTP service and accessible web application paths.

Nmap and Gobuster provided an initial understanding of the target's network services and web attack surface. The collected evidence and scan results are documented for further security assessment.

## 11. Disclaimer

All activities were performed within an isolated laboratory environment for educational purposes and authorized cybersecurity testing.

