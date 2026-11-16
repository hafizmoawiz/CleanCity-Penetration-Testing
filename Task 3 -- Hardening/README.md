# Task 3 — Linux Host Hardening

## Project Overview

This project focuses on hardening an Ubuntu Linux host to improve system security, reduce unnecessary network exposure, and strengthen access controls. It is part of the CleanCity Penetration Testing project.

The assessment covers SSH configuration, UFW firewall rules, review of running services, system updates, and post-hardening security validation. Additional checks were also performed for AppArmor and audit logging.

## Target Information

| Property | Details |
|---|---|
| Operating System | Ubuntu 22.04 LTS |
| Hostname | ubunto |
| Target IP | 172.16.229.131 |
| Assessment Type | Linux Host Hardening |
| Testing Platform | Kali Linux |
| Kali IP | 172.16.229.130 |

## Objectives

- Secure SSH remote access.
- Disable root and password-based SSH authentication.
- Configure firewall rules to restrict incoming traffic.
- Review running and enabled services.
- Apply available system updates.
- Enable automatic security updates.
- Perform post-hardening Nmap and Nikto scans.
- Document security improvements and remaining findings.

## Hardening Activities

1. **SSH Configuration:** Disabled root login, password authentication, keyboard-interactive authentication, and X11 forwarding. Enabled public-key authentication and configured approved ciphers. Verified key-based login.

2. **Firewall Configuration:** Enabled UFW with default incoming traffic denial and default outgoing traffic allowance. Restricted SSH (22) and HTTP (80) access to the authorized Kali testing machine.

3. **Service Review:** Reviewed running and enabled system services. No unnecessary services were identified, so existing services were retained to avoid affecting system operations.

4. **System Updates:** Applied available package updates and enabled automatic security upgrades using unattended-upgrades.

5. **Security Validation:** Performed post-hardening Nmap and Nikto scans to examine exposed network services and remaining web-server findings.

### Additional Security Checks

- **AppArmor:** Verified that AppArmor was active, with 54 profiles loaded, 52 in enforce mode and 2 in complain mode.
- **Audit Logging:** Installed and enabled auditd. Verified that audit logging was enabled and no lost events were reported during the check.

These were additional security checks and are not presented as separate mandatory hardening activities.

## Project Structure

```text
Task 3 -- Hardening/
├── evidence/
│   ├── before/
│   └── after/
├── scans/
│   ├── nmap/
│   └── owasp/
├── reports/
│   └── final-hardening-report.md
├── hardening-checklist.md
└── README.md
```

## Security Validation

### Nmap Scan

The post-hardening Nmap scan identified:

- SSH (22/tcp): Open
- HTTP (80/tcp): Open
- MariaDB (3306/tcp): Filtered
- Other scanned TCP ports: Filtered

SSH and HTTP remained accessible from the authorized testing environment, while the database port was not directly accessible.

A matching pre-hardening Nmap baseline was not available, so a direct before-and-after Nmap comparison could not be established.

### Nikto Scan — Before and After

The baseline Nikto report contained 16 reported items, while the post-hardening local scan reported 9 items.

The post-hardening scan no longer reported the previously identified directory-indexing findings for the four DVWA directories or the earlier configuration-information warning.

Some findings remained, including:

- Missing HttpOnly cookie attributes.
- Missing X-Frame-Options header.
- ETag inode information disclosure.
- `.git/index` exposure.
- Robots.txt observations.
- DVWA login-page exposure.

The reduction in reported items is an indication of improvement, not proof that every earlier issue was fully remediated. The original and post-hardening scans also used slightly different target paths, which should be considered when interpreting the comparison.

Nikto findings include informational observations as well as potential security issues.

## Evidence and Documentation

- `evidence/before/` — Baseline configuration screenshots.
- `evidence/after/` — Post-hardening configuration screenshots.
- `scans/nmap/` — Nmap scan results.
- `scans/owasp/` — Nikto scan results.
- `hardening-checklist.md` — Hardening activities and verification status.
- `reports/` — Final assessment report.

## Conclusion

The Ubuntu host was hardened through SSH security configuration, UFW firewall restrictions, service review, and system updates. SSH key-based authentication was verified, incoming traffic was restricted, and automatic security updates were enabled.

Post-hardening scans confirmed that the database port was filtered and identified a reduction in Nikto-reported items. Some web-server and DVWA-related findings remain and require further review.

This assessment documents the selected CIS-aligned hardening measures performed in the lab environment. It does not represent full CIS Benchmark certification.

## Disclaimer

This project was conducted in a controlled virtual lab environment for educational and cybersecurity training purposes. Testing was limited to authorized virtual machines.
