
# CleanCity Services Scheduling Server
# Security Assessment Report

## Project Information

| Field | Details |
|---|---|
| Project Name | Penetration Test and Hardening of CleanCity Services Scheduling Server |
| Client | CleanCity Services |
| Technology | Cybersecurity |
| Project Level | Intermediate |
| Intern | Hafiz Muhammad Moawiz |
| Assessment Phase | Task 1 – Initial Reconnaissance |
| Target Hostname | ubunto |
| Target IP Address | 172.16.229.131 |
| Operating System | Ubuntu 22.04 LTS |
| Web Application | DVWA |

---

## 1. Executive Summary

This report documents the initial security assessment of the CleanCity Services Scheduling Server in an isolated laboratory environment.

The first phase focused on preparing the testing environment, installing and configuring the Damn Vulnerable Web Application (DVWA), identifying network services, and discovering accessible web directories and files.

Nmap and Gobuster were used to perform initial reconnaissance. The results identified an accessible HTTP service running Apache HTTP Server 2.4.52 and multiple web application paths.

The findings provide an initial understanding of the target's attack surface. Further vulnerability assessment and system hardening are planned for the subsequent project phases.

## 2. Assessment Objectives

The objectives of the initial assessment were:

- Establish an isolated Ubuntu 22.04 testing environment.
- Install and configure DVWA.
- Identify the target system's IP address.
- Discover open ports and running services.
- Perform service detection using Nmap.
- Enumerate web directories and files using Gobuster.
- Collect screenshots and command outputs.
- Prepare initial reconnaissance documentation.

## 3. Scope and Methodology

### 3.1 Assessment Scope

| Component | Details |
|---|---|
| Target System | Ubuntu 22.04 Virtual Machine |
| Target IP | 172.16.229.131 |
| Web Server | Apache HTTP Server |
| Web Application | DVWA |
| Network Scanning | Nmap |
| Directory Enumeration | Gobuster |
| Testing Environment | Isolated Virtual Machine |

### 3.2 Assessment Methodology

The following activities were performed:

1. Laboratory environment preparation.
2. Installation of required software dependencies.
3. DVWA installation and configuration.
4. Target IP identification.
5. Network and service reconnaissance.
6. Web directory and file enumeration.
7. Documentation of findings and evidence.

## 4. Laboratory Environment

### 4.1 System Components

| Component | Version / Details |
|---|---|
| Operating System | Ubuntu 22.04 LTS |
| Virtualization | VMware Workstation |
| Web Server | Apache 2.4.52 |
| Database Server | MariaDB 10.6.23 |
| PHP | 8.1.2 |
| Vulnerable Application | DVWA |
| Network Scanner | Nmap 7.80 |
| Directory Scanner | Gobuster 2.0.1 |

### 4.2 DVWA Installation

DVWA was downloaded from its official GitHub repository and deployed under the Apache web root.

Application URL:

http://localhost/DVWA/

The application database and configuration were prepared to make the DVWA environment accessible for security testing.

## 5. Network Reconnaissance

### 5.1 Nmap Scan

Nmap was used to identify open ports, running services, and service versions.

**Command executed:**

```bash
sudo nmap -sV -A 172.16.229.131 \
-oN reconnaissance/nmap/initial-scan.txt
```

### 5.2 Nmap Results

| Port | State | Service | Detected Version |
|---|---|---|---|
| 80/tcp | Open | HTTP | Apache 2.4.52 (Ubuntu) |

**Additional observations:**

- Target host was reachable.
- Nmap reported 999 closed ports.
- HTTP server header identified Apache 2.4.52.
- The root web page displayed the default Apache Ubuntu page.
- Nmap suggested a Linux 2.6.32 OS fingerprint. This is an automated estimate and has not been independently verified.

### 5.3 Nmap Conclusion

The scan identified TCP port 80 as an open service running Apache HTTP Server. This confirmed that the target web server was reachable within the laboratory network.

## 6. Web Directory Enumeration

### 6.1 Gobuster Scan

Gobuster was used to identify accessible web paths using the DIRB common wordlist.

**Command executed:**

```bash
gobuster -m dir \
-u http://127.0.0.1/DVWA/ \
-w /usr/share/dirb/wordlists/common.txt \
-x php,txt,html \
-o reconnaissance/gobuster/dvwa-scan.txt
```

### 6.2 Discovered Paths

| Discovered Path | HTTP Status |
|---|---|
| /.git/HEAD | 200 |
| /about.php | 200 |
| /instructions.php | 200 |
| /login.php | 200 |
| /php.ini | 200 |
| /robots.txt | 200 |
| /security.txt | 200 |
| /setup.php | 200 |
| /config | 301 |
| /database | 301 |
| /docs | 301 |
| /external | 301 |
| /phpinfo.php | 302 |
| /security.php | 302 |

### 6.3 Preliminary Observations

- `/.git/HEAD` returned HTTP 200 and requires further investigation to determine whether Git metadata is exposed.
- `/php.ini` returned HTTP 200 and requires content inspection.
- Several paths returned HTTP 301 or 302, indicating redirects.
- Multiple `.ht*` paths returned HTTP 403, indicating access was denied.

**Note:** HTTP status codes alone do not confirm security vulnerabilities. These observations require manual validation.

## 7. Initial Security Observations

| Observation | Description | Further Action |
|---|---|---|
| Git metadata path | `/.git/HEAD` returned HTTP 200 | Verify actual metadata exposure |
| PHP configuration path | `/php.ini` returned HTTP 200 | Inspect returned content |
| Redirected directories | Multiple paths returned HTTP 301 | Inspect redirect destinations |
| Restricted paths | `.ht*` paths returned HTTP 403 | Record access restrictions |

These are preliminary observations and are not classified as confirmed vulnerabilities.

## 8. Evidence and Supporting Files

| Evidence | Project Location |
|---|---|
| Nmap Raw Output | reconnaissance/nmap/initial-scan.txt |
| Gobuster Raw Output | reconnaissance/gobuster/dvwa-scan.txt |
| Reconnaissance Report | reconnaissance/initial-recon.md |
| DVWA Screenshots | screenshots/01 dvwa-setup/ |
| Nmap Screenshots | screenshots/02 nmap/ |
| Gobuster Screenshots | screenshots/03 directory-enumeration/ |
| Setup Script | lab/scripts/setup.sh |

## 9. Assessment Status

| Project Phase | Status |
|---|---|
| Task 1 – Initial Reconnaissance | Completed |
| Task 2 – Vulnerability Assessment | Pending |
| Task 3 – Linux Host Hardening | Pending |
| Retesting and Compliance Evidence | Pending |
| Final Client Report | Pending |

## 10. Conclusion

The initial reconnaissance phase successfully established the laboratory environment and identified the target's exposed HTTP service and accessible web application paths.

Nmap identified Apache HTTP Server 2.4.52 running on TCP port 80. Gobuster discovered multiple web application paths, including pages and resources requiring further security validation.

The collected scan results, screenshots, and documentation provide a foundation for the next assessment phase.

No confirmed vulnerability is declared at this stage solely on the basis of reconnaissance results.

## 11. Disclaimer

All assessment activities documented in this report were performed within an isolated laboratory environment for educational purposes and authorized cybersecurity testing.

