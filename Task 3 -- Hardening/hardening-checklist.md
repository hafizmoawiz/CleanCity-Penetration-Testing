# Linux Host Hardening Checklist

**Project:** CleanCity – Task 3: Linux Host Hardening and Remediation Verification  
**Target OS:** Ubuntu 22.04 LTS  
**Hostname:** ubunto  
**Target IP:** 172.16.229.131  
**Testing Machine:** Kali Linux  
**Testing IP:** 172.16.229.130  
**Date:** 16 November 2026

---

## 1. SSH Configuration Hardening

| CIS-Aligned Security Control | Verification | Status |
|---|---|---|
| Disable SSH root login | `PermitRootLogin no` | PASS |
| Enable public-key authentication | `PubkeyAuthentication yes` | PASS |
| Disable password authentication | `PasswordAuthentication no` | PASS |
| Disable keyboard-interactive authentication | `KbdInteractiveAuthentication no` | PASS |
| Disable X11 forwarding | `X11Forwarding no` | PASS |
| Restrict SSH access to authorized user | `AllowUsers intern` | PASS |
| Configure strong SSH ciphers | Strong cipher list configured | PASS |
| Validate SSH configuration | `sudo sshd -t` | PASS |
| Verify SSH service | `systemctl is-active ssh` | PASS |
| Test key-based authentication | SSH key login tested successfully | PASS |

## 2. UFW Firewall Configuration

| Security Control | Verification | Status |
|---|---|---|
| Enable UFW firewall | `sudo ufw status verbose` | PASS |
| Set default incoming policy to DENY | Default: deny incoming | PASS |
| Set default outgoing policy to ALLOW | Default: allow outgoing | PASS |
| Allow SSH from trusted IP | Port 22 from `172.16.229.130` | PASS |
| Allow HTTP from trusted IP | Port 80 from `172.16.229.130` | PASS |
| Verify firewall rules | UFW status verified | PASS |

## 3. System Services Review

| Security Control | Verification | Status |
|---|---|---|
| Review running services | `systemctl list-units --type=service --state=running` | PASS |
| Review enabled services | `systemctl list-unit-files --type=service --state=enabled` | PASS |
| Identify non-essential services | Services reviewed for operational requirements | PASS |
| Retain required services | SSH, Apache and MariaDB verified active | PASS |

## 4. System Updates and Automatic Security Upgrades

| Security Control | Verification | Status |
|---|---|---|
| Update package repositories | `sudo apt update` | PASS |
| Apply pending system updates | `sudo apt upgrade` | PASS |
| Install unattended upgrades | `unattended-upgrades` configured | PASS |
| Verify unattended-upgrades service | `systemctl status unattended-upgrades` | PASS |
| Enable automatic package-list updates | `20auto-upgrades` verified | PASS |
| Enable automatic security upgrades | `20auto-upgrades` verified | PASS |

## 5. Additional Security Verification

### AppArmor

| Security Control | Verification | Status |
|---|---|---|
| Verify AppArmor module | `sudo aa-status` | PASS |
| Verify AppArmor service | `systemctl is-active apparmor` | PASS |
| Review loaded profiles | 54 profiles loaded | PASS |

### Auditd

| Security Control | Verification | Status |
|---|---|---|
| Install auditd | `sudo apt install auditd audispd-plugins` | PASS |
| Verify auditd service | `systemctl is-active auditd` | PASS |
| Verify audit subsystem | `sudo auditctl -s` | PASS |
| Verify audit enabled status | `enabled 1` | PASS |
| Verify lost audit events | `lost 0` | PASS |

## 6. Post-Hardening Security Scans

| Security Validation | Verification | Status |
|---|---|---|
| Perform post-hardening Nmap scan | Nmap service detection scan | PASS |
| Save Nmap scan output | Output stored in scans/nmap/ | PASS |
| Perform post-hardening Nikto scan | DVWA web application scan | PASS |
| Save Nikto scan output | Output stored in scans/owasp/ | PASS |
| Compare before and after results | Nikto reported items reduced from 16 to 9 | PASS |
| Capture scan evidence | Screenshots stored in evidence/ | PASS |

## 7. Evidence and Documentation

| Deliverable | Status |
|---|---|
| Before-hardening screenshots | PASS |
| After-hardening screenshots | PASS |
| Post-hardening Nmap output | PASS |
| Post-hardening Nikto output | PASS |
| README.md | PASS |
| Final client report | PASS |
| Hardening checklist | PASS |

---

## Final Compliance Summary

| Main Task Requirement | Status |
|---|---|
| SSH Configuration Hardening | PASS |
| UFW Firewall Configuration | PASS |
| System Services Review | PASS |
| System Updates and Automatic Security Upgrades | PASS |
| Post-Hardening Scanning and Verification | PASS |
| Evidence and Documentation | PASS |

**Overall Task Status: PASS – COMPLETED**

The Ubuntu host hardening activities were completed, security configurations were verified, and post-hardening scans and supporting evidence were collected.


