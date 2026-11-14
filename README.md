# CleanCity -- Cybersecurity Trial Week

## Project Overview

This repository documents the practical work completed during the
Cybersecurity Trial Week. The trial is organized into three tasks that
follow a basic security assessment lifecycle: **prepare an isolated lab,
assess vulnerabilities, and harden the environment**.

The purpose of this repository is to keep the work, evidence, findings,
and reports for each task organized in one place.

## Trial Week Tasks

### Task 1 -- Isolated Lab Creation

**Objective:** Build an isolated testing environment where security
assessment activities can be performed safely without affecting external
systems.

This task covers the lab setup and preparation of the target environment
used for the practical exercises.

**Deliverables:** - Lab setup and configuration documentation - Relevant
screenshots and supporting evidence - Task 1 report

**Task report:**\
[`Task 1 -- Isolation Lab Creation/reports/final-report.md`](Task%201%20--%20Isolation%20Lab%20Creation/reports/final-report.md)

### Task 2 -- Vulnerability Assessment

**Objective:** Identify and validate security weaknesses in the
intentionally vulnerable DVWA application hosted inside the lab.

The assessment included manual testing and automated scanning.
Activities covered SQL Injection, Reflected XSS, Stored XSS, Weak
Session IDs, security misconfiguration and directory listing, and
sensitive information exposure over HTTP. Nikto was also used to
identify additional web-server and configuration observations.

Where applicable, findings include evidence, impact, severity
considerations, and remediation recommendations. Scanner observations
are distinguished from issues that were manually validated.

**Deliverables:** - Vulnerability findings and assessment notes -
Screenshots and testing evidence - Nikto scan output - Task 2 report

**Task findings:**\
[`Task 2 Vulnerability-Assessment/findings.md`](Task%202%20Vulnerability-Assessment/findings.md)

### Task 3 -- Security Hardening

**Objective:** Apply appropriate security improvements to address the
weaknesses identified during the vulnerability assessment.

This task will focus on implementing suitable configuration and
application-level controls, then checking whether the changes reduce or
remove the identified risks.

**Planned activities may include:** - Disable directory listing and
restrict access to sensitive files and directories - Configure secure
cookie attributes, including `HttpOnly` and `Secure` where HTTPS is
enabled - Enforce HTTPS for application traffic - Add suitable security
headers, such as `X-Frame-Options` or an appropriate Content Security
Policy - Reduce unnecessary server and version information disclosure -
Review application input handling and output encoding - Re-test the
affected areas and document the results

**Deliverables:** - Hardening configuration and implementation notes -
Before-and-after validation evidence - Updated findings and remediation
status - Task 3 report

*Task 3 is planned/upcoming; update this section as hardening work is
completed.*

## Repository Structure

``` text
CleanCity-Penetration-Testing/
│
├── README.md
│
├── Task 1 -- Isolation Lab Creation/
│   └── reports/
│       └── final-report.md
│
├── Task 2 Vulnerability-Assessment/
│   ├── README.md
│   ├── findings.md
│   ├── screenshots/
│   └── reports/
│
└── Task 3 Hardening/
    ├── screenshots/
    ├── reports/
    └── ...
```

*The structure above is a high-level guide. Folder contents may expand
as each task progresses.*

## Tools and Environment

Tools used across the trial tasks include:

-   **Operating system / lab:** Ubuntu and an isolated virtual-machine
    environment
-   **Vulnerable web application:** Damn Vulnerable Web Application
    (DVWA)
-   **Web testing proxy:** Burp Suite Community Edition
-   **Web vulnerability scanner:** Nikto
-   **Browser and evidence review:** Firefox Developer Tools

Additional tools and configuration details are documented in the
relevant task folders.

## Assessment Workflow

1.  **Prepare:** Create and verify an isolated lab environment.
2.  **Assess:** Test the target application, identify weaknesses, and
    collect evidence.
3.  **Harden:** Apply security controls and re-test to validate
    improvements.
4.  **Document:** Maintain separate task-level reports and evidence,
    with this README serving as the overall project guide.

## Scope and Safety

All testing described in this repository is intended for the authorized,
isolated lab environment and the intentionally vulnerable DVWA
application. Do not run these tests against systems or applications
without explicit authorization.

## Project Status

  Task     Description                Status
  -------- -------------------------- -----------
  Task 1   Isolated Lab Creation      Completed
  Task 2   Vulnerability Assessment   Completed
  Task 3   Security Hardening         Upcoming

## Note

This README provides an overview of the complete three-task trial week.
Detailed procedures, screenshots, findings, and task-specific
conclusions are maintained in their respective folders.
