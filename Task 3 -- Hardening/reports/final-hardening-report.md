# FINAL CLIENT REPORT
## Task 3: Linux Host Hardening and Remediation Verification

**Project:** CleanCity – Penetration Testing and Host Hardening  
**Target System:** Ubuntu 22.04 LTS  
**Hostname:** ubunto  
**Target IP:** 172.16.229.131  
**Testing Machine:** Kali Linux  
**Testing IP:** 172.16.229.130  
**Assessment Date:** 16 November 2026  
**Status:** Completed

---

## 1. Executive Summary

This report presents the Linux host hardening activities performed on the Ubuntu 22.04 virtual machine as part of Task 3 of the CleanCity penetration testing project.

The objective was to improve the security posture of the Ubuntu host by applying selected CIS-aligned hardening measures, securing SSH access, configuring firewall restrictions, reviewing system services, applying system updates, and enabling automatic security upgrades.

After implementing the hardening measures, Nmap and Nikto scans were performed to validate the system configuration and assess the security improvements.

The assessment activities were completed, and supporting screenshots, scan outputs, and documentation were collected as evidence.

## 2. Scope and Environment

The assessment was conducted in a controlled virtual lab environment.

| Component | Configuration |
|---|---|
| Operating System | Ubuntu 22.04 LTS |
| Hostname | ubunto |
| Target IP | 172.16.229.131 |
| Testing System | Kali Linux |
| Testing IP | 172.16.229.130 |
| Web Server | Apache 2.4.52 |
| Database Server | MariaDB |
| Web Application | DVWA |
| Firewall | UFW |
| SSH Service | OpenSSH |

### Objectives

- Disable SSH root login.
- Enforce key-based SSH authentication.
- Configure strong SSH ciphers.
- Restrict incoming network traffic through UFW.
- Review running and enabled system services.
- Apply pending system updates.
- Enable automatic security upgrades.
- Perform post-hardening security scans.
- Document the results with screenshots and scan evidence.

## 3. SSH Configuration Hardening

SSH was secured by modifying the `/etc/ssh/sshd_config` configuration file.

### Security Changes Applied

The following settings were configured:

```text
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
KbdInteractiveAuthentication no
X11Forwarding no
AllowUsers intern
Ciphers aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes128-ctr
```

### Verification

The SSH configuration was validated using:

```bash
sudo sshd -t
```

The effective configuration was checked using:

```bash
sudo sshd -T
```

The SSH service was verified using:

```bash
sudo systemctl is-active ssh
```

Key-based authentication was tested successfully from the Kali Linux machine. Password-based authentication was also tested and rejected.

**Result:** SSH hardening was successfully implemented and verified.

## 4. UFW Firewall Configuration

The Uncomplicated Firewall (UFW) was configured to restrict incoming network access to trusted sources.

### Firewall Commands

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow from 172.16.229.130 to any port 22 proto tcp
sudo ufw allow from 172.16.229.130 to any port 80 proto tcp

sudo ufw enable
```

### Firewall Verification

```bash
sudo ufw status verbose
```

### Final Firewall Configuration

| Rule | Configuration |
|---|---|
| Incoming Traffic | DENY by default |
| Outgoing Traffic | ALLOW by default |
| SSH – Port 22 | Allowed from 172.16.229.130 |
| HTTP – Port 80 | Allowed from 172.16.229.130 |
| Other Incoming Traffic | Denied by default |

**Result:** UFW was successfully enabled and the configured firewall rules were verified.

## 5. System Services Review

Running and enabled services were reviewed using systemctl to identify services that were not required for the system's operation.

### Commands Used

```bash
systemctl list-units --type=service --state=running --no-pager

systemctl list-unit-files --type=service --state=enabled --no-pager
```

The services required for the lab environment were retained.

The following services were verified as active:

```bash
sudo systemctl is-active ssh
sudo systemctl is-active apache2
sudo systemctl is-active mariadb
```

All three services returned `active`.

**Result:** Service review was completed, and the required services were retained to maintain the intended functionality of the environment.

## 6. System Updates and Automatic Security Upgrades

The Ubuntu system was updated to apply available package updates.

### Commands Used

```bash
sudo apt update
sudo apt upgrade
```

The unattended-upgrades package was configured to support automatic security updates.

### Service Verification

```bash
sudo systemctl status unattended-upgrades
```

The service was verified as active and running.

### Automatic Update Configuration

The configuration file `/etc/apt/apt.conf.d/20auto-upgrades` was checked.

```text
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
```

**Result:** System updates were applied, and automatic package updates and unattended upgrades were enabled.

## 7. Additional Security Verification

Additional security checks were performed using AppArmor and Auditd.

### 7.1 AppArmor

AppArmor status was checked using:

```bash
sudo aa-status
```

The verification showed:

- AppArmor module loaded.
- 54 profiles loaded.
- 52 profiles in enforce mode.

The AppArmor service was also checked:

```bash
systemctl is-active apparmor
```

**Result:** AppArmor was active, and its security profiles were reviewed.

### 7.2 Auditd

Auditd and its plugins were installed using:

```bash
sudo apt install auditd audispd-plugins
```

The service was verified using:

```bash
sudo systemctl is-active auditd
```

Audit subsystem status was checked using:

```bash
sudo auditctl -s
```

The verification showed:

- Audit subsystem enabled: `1`
- Lost events: `0`

**Result:** Auditd was installed, active, and its subsystem status was verified.

## 8. Post-Hardening Nmap Scan

A post-hardening Nmap scan was performed from Kali Linux against the Ubuntu target.

### Command Used

```bash
nmap -sV -A -oN ~/post-hardening-nmap.txt 172.16.229.131
```

### Scan Results

| Port | State | Service | Version |
|---|---|---|---|
| 22/tcp | Open | SSH | OpenSSH 8.9p1 Ubuntu |
| 80/tcp | Open | HTTP | Apache 2.4.52 Ubuntu |

Additional scan observations:

- Host was reachable.
- 998 TCP ports were filtered.
- SSH and HTTP services were accessible.
- OS fingerprinting returned multiple possible Linux guesses without an exact match.

**Result:** The post-hardening Nmap scan verified the expected network service exposure.

## 9. Nikto Web Application Scan

Nikto was used to assess the DVWA web application before and after hardening.

### Post-Hardening Scan Command

```bash
nikto -h http://127.0.0.1/DVWA/ \
-output "$HOME/Downloads/Task 3 -- Hardening/scans/owasp/post-hardening-nikto-local.txt"
```

### Before and After Comparison

| Assessment | Reported Items |
|---|---:|
| Before Hardening | 16 |
| After Hardening | 9 |

The comparison demonstrated a reduction in the number of items reported by Nikto following the hardening activities.

The scan output was saved in the project's `scans/owasp/` directory for documentation and verification.

**Result:** Post-hardening web application scanning was completed, and the results demonstrated an improvement compared with the earlier assessment.

## 10. Compliance Summary

The following table summarizes the main activities completed for Task 3.

| Requirement | Status |
|---|---|
| SSH Configuration Hardening | PASS |
| UFW Firewall Configuration | PASS |
| System Services Review | PASS |
| System Updates | PASS |
| Automatic Security Upgrades | PASS |
| Post-Hardening Nmap Scan | PASS |
| Post-Hardening Nikto Scan | PASS |
| Evidence Collection | PASS |
| Documentation | PASS |

**Overall Task Status: PASS – COMPLETED**

## 11. Evidence and Deliverables

The project repository contains the following supporting evidence:

### Before-Hardening Evidence
- Initial system information.
- Ubuntu version and network configuration.
- Initial firewall status.
- Listening ports and services.
- Running services.
- SSH package information.
- Previous web application scan results.

### After-Hardening Evidence
- SSH service verification.
- UFW firewall status.
- Automatic updates configuration.
- Unattended-upgrades service status.
- AppArmor status and profile information.
- Auditd installation and status.
- Post-hardening Nmap output.
- Post-hardening Nikto output.

### Project Documentation

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

## 12. Conclusion

The Linux host hardening task was completed successfully. SSH access was secured through key-based authentication and restricted configuration, UFW was configured to allow only the required trusted inbound connections, and system services were reviewed.

System updates were applied, automatic security upgrades were enabled, and additional security verification was performed using AppArmor and Auditd.

Post-hardening Nmap and Nikto scans were conducted, and their outputs were saved as supporting evidence.

The completed checklist, scan results, screenshots, and technical documentation provide a record of the hardening work performed during this assessment.

**Final Status: Task 3 Completed**

---

**Prepared for:** CleanCity Penetration Testing Project  
**Assessment:** Linux Host Hardening and Remediation Verification  
**Date:** 16 November 2026
