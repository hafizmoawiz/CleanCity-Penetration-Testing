# FINAL CLIENT REPORT
## Task 3: Linux Host Hardening and Remediation Verification

**Project:** CleanCity Penetration Testing  
**Target System:** Ubuntu 22.04 LTS  
**Hostname:** ubunto  
**Target IP:** 172.16.229.131  
**Testing Machine:** Kali Linux  
**Testing Machine IP:** 172.16.229.130  
**Date:** 16 November 2026

---

## 1. Executive Summary

This task focused on hardening the Ubuntu Linux host and verifying the applied security measures. The work included SSH security configuration, UFW firewall restrictions, system service review, operating system updates, and post-hardening vulnerability scanning.

The system was hardened using selected CIS-aligned security practices. Post-hardening scans were conducted using Nmap and Nikto to examine the host's exposed services and web application security observations.

The results show that incoming network access is restricted, SSH password authentication is disabled, automatic security updates are enabled, and the host's security configuration has been improved.

## 2. Scope and Environment

The assessment was performed in a controlled virtual lab environment.

| Component | Details |
|---|---|
| Operating System | Ubuntu 22.04 LTS |
| Hostname | ubunto |
| Target IP | 172.16.229.131 |
| Testing OS | Kali Linux |
| Tester IP | 172.16.229.130 |
| Web Server | Apache |
| Database | MariaDB |
| Web Application | DVWA |
| Firewall | UFW |

Apache, MariaDB, and DVWA were retained because they are required for the lab environment.

## 3. SSH Configuration Hardening

SSH configuration was hardened by editing `/etc/ssh/sshd_config`.

The following security settings were applied:

- `PermitRootLogin no` — Disabled direct root login.
- `PubkeyAuthentication yes` — Enabled SSH key-based authentication.
- `PasswordAuthentication no` — Disabled password-based SSH authentication.
- `KbdInteractiveAuthentication no` — Disabled keyboard-interactive authentication.
- `X11Forwarding no` — Disabled X11 forwarding.
- `AllowUsers intern` — Restricted SSH access to the authorized user.
- Strong encryption ciphers were configured.

**Verification:**

- SSH service status was checked and confirmed active.
- SSH configuration syntax was validated.
- Key-based authentication was successfully tested.
- Password-based authentication was rejected.

**Result:** SSH access is restricted to the authorized user using key-based authentication.

## 4. UFW Firewall Configuration

The UFW firewall was enabled and configured to restrict incoming network connections.

The following rules were applied:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow from 172.16.229.130 to any port 22 proto tcp
sudo ufw allow from 172.16.229.130 to any port 80 proto tcp

sudo ufw enable
sudo ufw status verbose
```

**Verified firewall configuration:**

| Port | Service | Action | Allowed Source |
|---|---|---|---|
| 22/tcp | SSH | ALLOW IN | 172.16.229.130 |
| 80/tcp | HTTP | ALLOW IN | 172.16.229.130 |
| Other incoming ports | All other services | DENY | All |

The firewall verification showed:

- UFW status: Active
- Default incoming policy: Deny
- Default outgoing policy: Allow
- Firewall logging: Enabled (Low)

**Result:** Only SSH and HTTP access from the trusted Kali testing machine is permitted by the configured rules.

## 5. Review of Running Services

Running and enabled services were reviewed using `systemctl`.

Commands used:

```bash
systemctl list-units --type=service --state=running --no-pager

systemctl list-unit-files --type=service --state=enabled --no-pager
```

The review identified services required for the system's operation and the penetration-testing environment.

The following essential services were verified as active:

```bash
sudo systemctl is-active ssh
sudo systemctl is-active apache2
sudo systemctl is-active mariadb
```

All three services returned `active`.

No unnecessary service was identified for removal. Therefore, no services were disabled, ensuring that the required lab functionality remained available.

**Result:** Service review completed and essential services retained.

## 6. System Updates and Automatic Security Updates

The Ubuntu system packages were updated using:

```bash
sudo apt update
sudo apt upgrade
```

Automatic security updates were configured using the `unattended-upgrades` package.

Verification commands:

```bash
sudo systemctl status unattended-upgrades

cat /etc/apt/apt.conf.d/20auto-upgrades
```

The verification confirmed:

- `unattended-upgrades` service: Active (running)
- Service startup: Enabled
- Automatic package list updates: Enabled
- Automatic unattended upgrades: Enabled

The configuration contained:

```text
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
```

**Result:** System updates were applied and automatic unattended upgrades were enabled.

## 7. Additional Security Verification

The following additional security checks were performed during the hardening process.

### 7.1 AppArmor

AppArmor status was checked using:

```bash
sudo aa-status
```

Results:

- AppArmor module: Loaded
- Profiles loaded: 54
- Profiles in enforce mode: 52
- Profiles in complain mode: 2

The AppArmor service was also verified as active.

### 7.2 Auditd

The audit logging package was installed and verified.

Commands:

```bash
sudo systemctl is-active auditd
sudo auditctl -s
```

Results:

- Auditd service: Active
- Audit subsystem enabled: 1
- Lost audit events: 0

These checks provide additional evidence of host security monitoring.

## 8. Post-Hardening Nmap Scan

A post-hardening Nmap scan was performed from Kali Linux against the Ubuntu target.

Command:

```bash
nmap -sV -A -O -oN ~/post-hardening-nmap.txt 172.16.229.131
```

**Scan Results:**

| Port | State | Service | Version |
|---|---|---|---|
| 22/tcp | Open | SSH | OpenSSH 8.9p1 |
| 80/tcp | Open | HTTP | Apache 2.4.52 |
| Other 998 TCP ports | Filtered | — | — |

Additional observations:

- The target host was reachable.
- Nmap identified SSH and HTTP as open.
- 998 TCP ports were filtered.
- OS fingerprinting produced multiple Linux guesses.
- No exact OS match was identified because the scan conditions were not ideal.

**Result:** The scan confirmed that the expected SSH and HTTP services remained accessible while most other TCP ports were filtered.

*Note: No original pre-hardening Nmap report was available for a direct before-and-after Nmap comparison.*

## 9. Post-Hardening Nikto Scan

Nikto was used to scan the DVWA web application after hardening.

Command:

```bash
nikto -h http://127.0.0.1/DVWA/ \
-output "$HOME/Downloads/Task 3 -- Hardening/scans/owasp/post-hardening-nikto-local.txt"
```

**Scan Details:**

| Property | Value |
|---|---|
| Tool | Nikto |
| Version | 2.1.5 |
| Target | 127.0.0.1 |
| Application | DVWA |
| Port | 80 |
| Reported Items | 9 |

### 9.1 Before-and-After Comparison

| Observation | Before Hardening | After Hardening |
|---|---|---|
| Total reported items | 16 | 9 |
| Cookie HttpOnly flag | Reported | Still reported |
| X-Frame-Options | Missing | Still missing |
| ETag inode disclosure | Reported | Still reported |
| Directory indexing | Reported in four directories | Not reported |
| Configuration information exposure | Reported | Not reported |
| robots.txt observation | Reported | Still reported |
| Git index exposure | Reported | Still reported |
| DVWA login page | Detected | Detected |

The after-scan still reported cookie security flags, missing X-Frame-Options, ETag inode information, robots.txt observations, the Git index file, and the DVWA login page.

The reduction from 16 to 9 reported items indicates fewer observations in the later scan. However, findings that were not reported in the later scan should not automatically be considered fixed without separate manual verification.

**Important comparison limitation:** The original scan targeted `localhost` on port 80, while the later scan targeted `127.0.0.1/DVWA/`. Therefore, the results are indicative rather than a perfectly identical scan comparison. Nikto findings also include informational observations and do not all represent confirmed vulnerabilities.

## 10. Before-and-After Compliance Summary

The following table summarizes the five main hardening activities performed for this task.

| Requirement | Implementation / Verification | Status |
|---|---|---|
| SSH configuration | Root login disabled; key-based authentication enforced | PASS |
| UFW firewall | Incoming traffic denied by default; SSH and HTTP restricted to trusted IP | PASS |
| Service review | Running and enabled services reviewed; essential services retained | PASS |
| System updates | Packages updated and automatic upgrades enabled | PASS |
| Scan verification | Post-hardening Nmap and Nikto scans completed | PASS |

These results represent completion of the selected task requirements. They do not constitute certification against the entire CIS Ubuntu Benchmark.

## 11. Remaining Security Observations

The post-hardening Nikto scan continued to report several web application observations:

1. Missing HttpOnly cookie security flags.
2. Missing X-Frame-Options header.
3. ETag inode information disclosure.
4. Git index file exposure.
5. robots.txt information.
6. DVWA login page detection.

These observations should be considered for future web application hardening. DVWA is intentionally maintained as a vulnerable training application, so some findings may be expected within this lab environment.

## 12. Evidence and Deliverables

The following evidence was collected during the task:

- Before-hardening system and network screenshots.
- SSH configuration and authentication verification.
- UFW firewall status and rules.
- Running and enabled services review.
- System update and unattended-upgrades verification.
- AppArmor status and profile information.
- Auditd installation and status verification.
- Post-hardening Nmap scan output.
- Post-hardening Nikto scan output.
- Before-and-after Nikto comparison.

Project evidence and reports are organized in the following structure:

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

## 13. Conclusion

The Ubuntu host was successfully hardened using the selected security measures. SSH access was restricted through key-based authentication, UFW was configured to limit incoming connections, system services were reviewed, and system updates with automatic security upgrades were enabled.

Additional AppArmor and Auditd checks provided evidence of security enforcement and audit monitoring. Post-hardening Nmap and Nikto scans were completed to verify the resulting host and web application security posture.

The assessment demonstrates improved host-level security while preserving the essential services required for the CleanCity penetration-testing environment.

**Final Status: The five selected Task 3 hardening activities were completed and verified.**
