# Task 3 – Linux Host Hardening and Remediation Verification

## Project Overview

This project focuses on hardening an Ubuntu Linux host using selected security practices aligned with the CIS Ubuntu Benchmark. The main objective was to improve system security through SSH configuration, firewall restrictions, service review, system updates, and post-hardening security scans.

## Objectives

- Secure SSH access and disable root login.
- Enforce SSH key-based authentication.
- Configure UFW firewall with restricted inbound access.
- Review running and enabled system services.
- Install pending system updates.
- Enable automatic security updates.
- Perform post-hardening Nmap and Nikto scans.
- Maintain evidence and a hardening compliance checklist.

## Lab Environment

| Component | Details |
|---|---|
| Target OS | Ubuntu 22.04 LTS |
| Target Hostname | ubunto |
| Target IP | 172.16.229.131 |
| Testing Machine | Kali Linux |
| Kali IP | 172.16.229.130 |
| Web Server | Apache 2.4.52 |
| Database | MariaDB |
| Web Application | DVWA |

## Hardening Activities

### 1. SSH Configuration

SSH was hardened by applying the following security settings:

- Disabled root login.
- Enabled public-key authentication.
- Disabled password authentication.
- Disabled keyboard-interactive authentication.
- Disabled X11 forwarding.
- Restricted SSH access to the authorized user.
- Configured strong SSH ciphers.

SSH configuration was validated, and key-based login was successfully tested.

### 2. UFW Firewall Configuration

UFW was enabled with the following default policies:

- Default incoming traffic: DENY
- Default outgoing traffic: ALLOW
- SSH (Port 22): Allowed from Kali IP `172.16.229.130`
- HTTP (Port 80): Allowed from Kali IP `172.16.229.130`

All other unsolicited incoming traffic is denied by default.

### 3. System Services Review

Running and enabled services were reviewed using `systemctl`.

The review identified the services required for the system's operational functionality. Existing required services, including SSH, Apache, and MariaDB, were retained.

### 4. System Updates

The following maintenance activities were completed:

- Updated package repositories using `apt update`.
- Applied pending package updates using `apt upgrade`.
- Verified the unattended-upgrades service.
- Enabled automatic package-list updates and unattended security upgrades.

### 5. Additional Security Verification

Additional security checks were performed:

**AppArmor**
- Verified that the AppArmor module was loaded.
- Confirmed that the AppArmor service was active.
- Reviewed loaded security profiles and their enforcement modes.

**Auditd**
- Installed `auditd` and `audispd-plugins`.
- Verified that the auditd service was active.
- Checked audit subsystem status using `auditctl -s`.

## Security Scanning and Verification

### Nmap

A post-hardening Nmap scan was performed from the Kali Linux machine against the Ubuntu target.

Command:

```bash
nmap -sV -A -oN ~/post-hardening-nmap.txt 172.16.229.131
```

The scan verified the availability of required services:

- SSH: Port 22 open.
- HTTP: Port 80 open.
- Other scanned TCP ports: Filtered.

The scan output was saved as evidence.

### Nikto

Nikto was used to assess the DVWA web application before and after hardening.

Post-hardening scan command:

```bash
nikto -h http://127.0.0.1/DVWA/ \
-output "$HOME/Downloads/Task 3 -- Hardening/scans/owasp/post-hardening-nikto-local.txt"
```

The comparison showed a reduction in reported items from **16 before hardening to 9 after hardening**, demonstrating improvement in the scan results.

## Project Structure

```text
Task 3 -- Hardening/
│
├── evidence/
│   ├── before/
│   └── after/
│
├── scans/
│   ├── nmap/
│   └── owasp/
│
├── reports/
│   └── final-hardening-report.md
│
├── hardening-checklist.md
└── README.md
```

## Compliance Checklist

The `hardening-checklist.md` file documents the completed hardening activities and their verification status.

| Hardening Activity | Status |
|---|---|
| SSH Configuration | PASS |
| UFW Firewall Configuration | PASS |
| System Services Review | PASS |
| System Updates | PASS |
| Automatic Security Updates | PASS |
| Post-Hardening Security Scans | PASS |
| Evidence Collection | PASS |

## Conclusion

The Ubuntu host was hardened through SSH security configuration, UFW firewall restrictions, system service review, and regular system updates. Automatic security upgrades were enabled, and additional AppArmor and Auditd checks were performed.

Post-hardening Nmap and Nikto scans were conducted to validate the security improvements. Screenshots, scan outputs, and documentation are maintained in this repository as project evidence.

**Project Status: Completed**
