# CleanCity -- Cybersecurity Trial Week

## Project Overview

This repository documents the practical work completed during the
**Cybersecurity Trial Week**. The trial consists of three tasks covering
isolated lab creation, vulnerability assessment, and security hardening.

The project uses **Damn Vulnerable Web Application (DVWA)** as the
target application in a controlled local lab environment.

## Trial Week Tasks

### Task 1 -- Isolation Lab Creation

**Objective:** Set up an isolated penetration testing environment for
conducting security assessments safely.

**Activities performed:** - Installed and configured Apache, MariaDB,
and PHP. - Deployed DVWA on the Ubuntu environment. - Verified the DVWA
installation and local accessibility. - Identified the target IP
address. - Performed initial reconnaissance using Nmap. - Conducted
directory enumeration using Gobuster.

**Deliverables:** - Lab setup scripts and configuration. - Nmap scan
results. - Gobuster directory enumeration results. - Practical report
and supporting screenshots.

**Documentation:** - [Task 1
README](Task%201%20--%20Isolation%20Lab%20Creation/README.md) - [Task 1
Final
Report](Task%201%20--%20Isolation%20Lab%20Creation/reports/final-report.md) -
[Task 1 PDF
Report](Task%201%20--%20Isolation%20Lab%20Creation/reports/CleanCity_Task1_Reconnaissance_Practical_Report.pdf)

### Task 2 -- Vulnerability Assessment

**Objective:** Identify and analyze security vulnerabilities in the DVWA
application using manual testing and security assessment tools.

**Activities performed:** - Configured Burp Suite as an intercepting
proxy. - Tested SQL Injection. - Tested Reflected Cross-Site Scripting
(XSS). - Tested Stored Cross-Site Scripting (XSS). - Assessed Weak
Session IDs. - Performed web vulnerability scanning using Nikto. -
Identified and addressed a directory listing security
misconfiguration. - Examined sensitive information transmitted through
HTTP login requests.

**Tools used:** - Burp Suite - Nikto - Firefox - DVWA

**Deliverables:** - Vulnerability assessment findings. - Nikto scan
report. - Practical screenshots and evidence. - Detailed vulnerability
assessment report.

**Documentation:** - [Task 2
README](Task%202%20--%20Vulnerability-Assessment/README.md) - [Task 2
Findings](Task%202%20--%20Vulnerability-Assessment/Reports/findings.md) -
[Task 2 PDF
Report](Task%202%20--%20Vulnerability-Assessment/Reports/CleanCity_Task2_Vulnerability_Assessment_Report.pdf) -
[Nikto Scan
Report](Task%202%20--%20Vulnerability-Assessment/Reports/nikto-report.txt)

### Task 3 -- Security Hardening

**Objective:** Improve the security of the lab environment and address
identified security weaknesses through appropriate hardening measures.

**Planned activities:** - Review findings from the vulnerability
assessment. - Apply appropriate security configurations. - Disable
unnecessary services and directory listing. - Improve HTTP security
headers. - Strengthen cookie security attributes. - Review application
and server configurations. - Verify implemented security improvements.

**Documentation:** - [Task 3 Hardening
Checklist](Task%203%20--%20Hardening/hardening-checklist.md)

*Task 3 documentation will be updated as hardening activities are
completed.*

## Repository Structure

``` text
CleanCity-Penetration-Testing/
│
├── Task 1 -- Isolation Lab Creation/
│   ├── lab/
│   │   └── scripts/
│   │       └── setup.sh
│   ├── reconnaissance/
│   │   ├── gobuster/
│   │   ├── nmap/
│   │   └── initial-recon.md
│   ├── reports/
│   │   ├── CleanCity_Task1_Reconnaissance_Practical_Report.pdf
│   │   └── final-report.md
│   ├── screenshots/
│   └── README.md
│
├── Task 2 -- Vulnerability-Assessment/
│   ├── 01 Initial Steps/
│   ├── 02 SQL Injection/
│   ├── 03 Reflected XSS/
│   ├── 04 Stored XSS/
│   ├── 05 Weak Session ID/
│   ├── 06 Nikto/
│   ├── 07 Security Misconfiguration/
│   ├── 08 Sensitive Data Exposure/
│   ├── Reports/
│   │   ├── CleanCity_Task2_Vulnerability_Assessment_Report.pdf
│   │   ├── findings.md
│   │   └── nikto-report.txt
│   └── README.md
│
└── Task 3 -- Hardening/
    └── hardening-checklist.md
```

## Testing Environment

  Component             Details
  --------------------- ----------------------------------------
  Target Application    Damn Vulnerable Web Application (DVWA)
  Operating System      Ubuntu
  Web Server            Apache
  Database              MariaDB
  Testing Tools         Nmap, Gobuster, Burp Suite, Nikto
  Testing Environment   Isolated Local Lab

## Scope and Safety

All penetration testing activities documented in this repository were
performed against the intentionally vulnerable DVWA application in a
controlled lab environment for educational and assessment purposes.

No unauthorized systems were targeted.

## Project Progress

  Task     Description                Status
  -------- -------------------------- -----------
  Task 1   Isolation Lab Creation     Completed
  Task 2   Vulnerability Assessment   Completed
  Task 3   Security Hardening         Pending

------------------------------------------------------------------------

**Project:** CleanCity -- Cybersecurity Trial Week\
**Focus:** Lab Setup, Vulnerability Assessment, and Security Hardening
