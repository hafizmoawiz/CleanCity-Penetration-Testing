# Initial Reconnaissance Report

## Project Information

| Item | Details |
|---|---|
| Project | Penetration Test and Hardening of CleanCity Services Scheduling Server |
| Client | CleanCity Services |
| Assessment phase | Task 1 – Initial Reconnaissance |
| Target hostname | `ubunto` |
| Target IP address | `172.16.229.131` |
| Web application | Damn Vulnerable Web Application (DVWA) |
| Web application URL | `http://127.0.0.1/DVWA/` (from inside the target VM) |
| Assessment environment | Isolated Ubuntu lab VM |

## 1. Objective

The objective of this phase was to identify the target's reachable network services and discover web paths exposed by the DVWA installation. Nmap was used for service/version detection and Gobuster was used for web directory and file enumeration.

## 2. Nmap Reconnaissance

### Command executed

```bash
sudo nmap -sV -A 172.16.229.131 -oN reconnaissance/nmap/initial-scan.txt
```

### Results

The target host `172.16.229.131` was reachable. The supplied Nmap output reports one open port among the scanned ports:

| Port | State | Service | Detected version |
|---|---|---|---|
| `80/tcp` | Open | HTTP | Apache httpd `2.4.52` (Ubuntu) |

Additional observations from the scan:

- HTTP server header: `Apache/2.4.52 (Ubuntu)`.
- HTTP title at the server root: `Apache2 Ubuntu Default Page: It works`.
- Nmap reported 999 closed ports.
- Nmap's OS fingerprint suggested Linux `2.6.32`. This is an automated fingerprint estimate and has not been independently confirmed.

The Apache default page title refers to the web server root (`/`). DVWA was accessed separately under the `/DVWA/` path.

### Nmap evidence

Raw output: `reconnaissance/nmap/initial-scan.txt`

Screenshots: `screenshots/` (Nmap evidence folder).

## 3. Web Directory and File Enumeration

### Tool and wordlist

- Tool: Gobuster `2.0.1` (legacy command-line syntax).
- Wordlist: `/usr/share/dirb/wordlists/common.txt`
- Target: `http://127.0.0.1/DVWA/`

### Command

```bash
gobuster -m dir -u http://127.0.0.1/DVWA/ -w /usr/share/dirb/wordlists/common.txt -x php,txt,html
```

### Discovered paths

The following entries are transcribed from the supplied Gobuster output. Repeated entries in the raw output are listed once here.

| Discovered path | HTTP status | Initial observation |
|---|---:|---|
| `/.git/HEAD` | 200 | Response received; verify whether Git metadata/content is actually exposed. |
| `/about.php` | 200 | PHP page responded successfully. |
| `/config` | 301 | Redirect response; inspect the destination before drawing conclusions. |
| `/database` | 301 | Redirect response; inspect the destination before drawing conclusions. |
| `/docs` | 301 | Redirect response; inspect the destination before drawing conclusions. |
| `/external` | 301 | Redirect response; inspect the destination before drawing conclusions. |
| `/favicon.ico` | 200 | Favicon resource found. |
| `/index.php` | 302 | Redirect response. |
| `/instructions.php` | 200 | Instructions page responded successfully. |
| `/logout.php` | 302 | Redirect response. |
| `/login.php` | 200 | Login page responded successfully. |
| `/php.ini` | 200 | Response received; inspect its contents and exposure risk. |
| `/phpinfo.php` | 302 | Redirect response. |
| `/robots.txt` | 200 | Robots file found. |
| `/security.php` | 302 | Redirect response. |
| `/security.txt` | 200 | Security information file found. |
| `/setup.php` | 200 | DVWA setup page responded successfully. |
| `/tests` | 301 | Redirect response; inspect the destination before drawing conclusions. |

The scan also returned HTTP `403` for the following paths:

- `/.hta`, `/.hta.php`, `/.hta.txt`, `/.hta.html`
- `/.htaccess`, `/.htaccess.php`, `/.htaccess.txt`, `/.htaccess.html`
- `/.htpasswd`, `/.htpasswd.php`, `/.htpasswd.txt`, `/.htpasswd.html`

A `403 Forbidden` response indicates that access was denied for the request. It does not prove that the files are readable.

### Preliminary observations

1. `/.git/HEAD` returned HTTP 200. This should be manually checked to determine whether repository metadata is accessible and whether any sensitive source information can be retrieved.
2. `/php.ini` returned HTTP 200. Its response should be inspected to determine whether it exposes configuration information or is simply a non-sensitive response.
3. Several paths returned HTTP 301 or 302. These are redirects, not proof that the corresponding content is accessible.
4. The `.ht*` paths returned HTTP 403, showing that the server denied those requests during this scan.

**Important:** An HTTP status code alone does not confirm a vulnerability. The observations above are leads for validation during the vulnerability-assessment phase, not confirmed findings.

### Gobuster evidence

Raw output: `reconnaissance/gobuster/dvwa-scan.txt`

Screenshots: `screenshots/` (Directory Enumeration evidence folder).

## 4. Initial Attack Surface Summary

| Area | Observation |
|---|---|
| Host availability | Target responded to Nmap. |
| Network service | HTTP on TCP port 80 was identified as open. |
| Web server | Apache `2.4.52` on Ubuntu was detected. |
| Web application | DVWA was accessed under `/DVWA/`. |
| Web enumeration | Gobuster identified PHP pages, text files, directories/redirects, and restricted `.ht*` paths. |
| Items requiring validation | `/.git/HEAD` and `/php.ini` returned HTTP 200. |

## 5. Conclusion

Initial reconnaissance identified the target VM at `172.16.229.131`, with Apache HTTP service on TCP port 80. Gobuster discovered multiple DVWA-related pages and paths, including entries that require further inspection. The results provide an initial map of the web attack surface for the next assessment phase.

No vulnerability is declared confirmed solely on the basis of these scan results. Potentially sensitive paths and redirect responses must be manually validated during the vulnerability-assessment phase.

## 6. Evidence and Supporting Files

- Nmap raw output: `reconnaissance/nmap/initial-scan.txt`
- Gobuster raw output: `reconnaissance/gobuster/dvwa-scan.txt`
- Screenshots: the three existing evidence folders under `screenshots/`

## 7. Scope and Safety Note

All scanning described in this report was performed against the intentionally vulnerable DVWA application in the isolated lab environment. The target was not a public production system.
