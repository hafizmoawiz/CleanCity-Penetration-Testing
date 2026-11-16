# Linux Host Hardening Checklist
## Task 3 — CleanCity Penetration Testing

**Target:** Ubuntu 22.04 LTS  
**Hostname:** ubunto  
**Target IP:** 172.16.229.131  
**Testing IP:** 172.16.229.130  
**Assessment Date:** 16 November 2026

**Status:** PASS = Completed and verified, REVIEWED = Reviewed and no removal required.

## 1. SSH Configuration Hardening

| Security Control | Verification | Status |
|---|---|---|
| Disable root SSH login | `sshd -T` | PASS |
| Disable password authentication | `sshd -T` | PASS |
| Enable public key authentication | `sshd -T` | PASS |
| Disable keyboard-interactive authentication | `sshd -T` | PASS |
| Disable X11 forwarding | `sshd -T` | PASS |
| Restrict SSH access to authorized user | `AllowUsers intern` | PASS |
| Configure approved SSH ciphers | `sshd -T` | PASS |
| Verify SSH configuration syntax | `sudo sshd -t` | PASS |
| Verify SSH key-based login | Kali SSH connection test | PASS |
| Verify password login is rejected | Password authentication test | PASS |

## 2. UFW Firewall Configuration

| Security Control | Verification | Status |
|---|---|---|
| Enable UFW firewall | `sudo ufw status verbose` | PASS |
| Default deny incoming traffic | UFW status | PASS |
| Default allow outgoing traffic | UFW status | PASS |
| Allow SSH TCP/22 from trusted IP | Rule for 172.16.229.130 | PASS |
| Allow HTTP TCP/80 from trusted IP | Rule for 172.16.229.130 | PASS |
| Restrict other incoming traffic | Default deny policy | PASS |
| Verify database port restriction | Nmap shows TCP/3306 filtered | PASS |

## 3. Unnecessary Services Review

| Security Control | Verification | Status |
|---|---|---|
| Review running services | `systemctl list-units --type=service --state=running` | PASS |
| Review enabled services | `systemctl list-unit-files --type=service --state=enabled` | PASS |
| Identify unnecessary services | Services reviewed for lab requirements | PASS |
| Disable unnecessary services | No unnecessary service identified for removal | REVIEWED |

**Service review note:** Existing services were retained because no unnecessary service was identified in the current lab environment.

## 4. System Updates and Automatic Security Upgrades

| Security Control | Verification | Status |
|---|---|---|
| Update package information | `sudo apt update` | PASS |
| Apply available system upgrades | `sudo apt upgrade` | PASS |
| Enable automatic package-list updates | `/etc/apt/apt.conf.d/20auto-upgrades` | PASS |
| Enable automatic security upgrades | Unattended-upgrades configuration | PASS |
| Verify unattended-upgrades service | `systemctl is-active unattended-upgrades` | PASS |

## 5. Post-Hardening Security Scanning

| Security Control | Verification | Status |
|---|---|---|
| Perform post-hardening Nmap scan | `post-hardening-nmap.txt` | PASS |
| Perform post-hardening Nikto scan | `post-hardening-nikto-local.txt` | PASS |
| Preserve original Nikto report | Original Nikto report | PASS |
| Compare before and after Nikto results | 16 reported items before, 9 after | PASS |
| Document remaining findings | Final client report | PASS |
| Save scan outputs in project repository | `scans/nmap/` and `scans/owasp/` | PASS |

### Nikto Comparison Summary

| Observation | Before | After |
|---|---|---|
| Total reported items | 16 | 9 |
| Directory indexing findings | 4 reported | Not reported |
| Configuration exposure warning | Reported | Not reported |
| Missing HttpOnly flag | Reported | Still reported |
| Missing X-Frame-Options | Reported | Still reported |
| ETag inode disclosure | Reported | Still reported |
| Git index exposure | Reported | Still reported |

**Note:** Findings no longer reported in the later scan are described as not detected, not automatically as permanently remediated.

## 6. Additional Security Verification

The following security mechanisms were also checked as additional host-security work:

| Security Mechanism | Verification | Result |
|---|---|---|
| AppArmor service | `systemctl is-active apparmor` | Active |
| AppArmor profiles | `sudo aa-status` | 52 enforce, 2 complain |
| Auditd service | `systemctl is-active auditd` | Active |
| Audit subsystem | `sudo auditctl -s` | Enabled |

Additional audit-rule coverage and the two complain-mode AppArmor profiles may be reviewed separately. They are not counted as incomplete steps in the five-item Task 3 assignment.

## 7. Evidence and Deliverables

| Evidence | Location | Status |
|---|---|---|
| Before-hardening screenshots | `evidence/before/` | Collected |
| After-hardening screenshots | `evidence/after/` | Collected |
| Post-hardening Nmap scan | `scans/nmap/` | Completed |
| Original Nikto report | `evidence/before/` or original report location | Available |
| Post-hardening Nikto report | `scans/owasp/` | Completed |
| Before/after comparison | `reports/` | Completed |
| Final client report | `reports/final-hardening-report.md` | Prepared |
| README | Project root | Prepared |

## 8. Final Task Status

| Required Task | Status |
|---|---|
| 1. SSH configuration hardening | PASS |
| 2. UFW firewall configuration | PASS |
| 3. Review and disable unnecessary services | PASS |
| 4. Apply updates and enable automatic security upgrades | PASS |
| 5. Re-run scans and document remediation | PASS |

**Final Assessment:** All five required Task 3 activities have been completed based on the available configuration checks, scan outputs, and evidence.

**Compliance Note:** This checklist documents selected CIS-aligned host-hardening measures. It does not represent a complete CIS Ubuntu Benchmark audit or certification.
