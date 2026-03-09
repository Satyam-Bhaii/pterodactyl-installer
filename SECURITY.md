# 🔒 Security Policy

**Made by SATYAM BHAIi**

Version: 3.1

---

## 📋 Table of Contents

1. [Supported Versions](#-supported-versions)
2. [Reporting a Vulnerability](#-reporting-a-vulnerability)
3. [Security Best Practices](#-security-best-practices)
4. [Known Limitations](#-known-limitations)

---

## 📦 Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 3.0.x   | ✅ Yes             |
| 2.0.x   | ⚠️ Security updates only |
| 1.0.x   | ❌ No              |

**Always use the latest version for best security!**

---

## 🚨 Reporting a Vulnerability

We take security vulnerabilities seriously. Thank you for disclosing them responsibly!

### How to Report

**Option 1: GitHub Security Advisory (Recommended)**
1. Go to https://github.com/Satyam-Bhaii/pterodactyl-installer/security
2. Click "Report a vulnerability"
3. Fill out the form
4. Submit

**Option 2: Email**
- Send to: satyambhaii@example.com
- Subject: `[SECURITY] Vulnerability Report`
- Include detailed description

### What to Include

When reporting a vulnerability, please provide:

- **Type of issue** (e.g., SQL injection, XSS, privilege escalation)
- **Full paths** of affected files
- **Step-by-step reproduction** instructions
- **Impact** of the vulnerability
- **Suggested fix** (if any)

### Response Time

- **Initial response:** Within 48 hours
- **Status update:** Within 1 week
- **Fix timeline:** Depends on severity (1-4 weeks)

### Disclosure Policy

- Please allow reasonable time for a fix before public disclosure
- We will coordinate with you on public disclosure timing
- We appreciate responsible disclosure and will credit you (with permission)

---

## 🛡️ Security Best Practices

### During Installation

```bash
# ✅ DO: Run with sudo (not as root directly)
sudo ./pterodactyl-installer.sh

# ❌ DON'T: Download from untrusted sources
# Only use official URLs:
# - https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh
```

### After Installation

#### 1. Change Default Passwords

```bash
# Default credentials are for initial setup only
# Change immediately after first login!
```

**In Panel:**
1. Login with default credentials
2. Go to Account → Password
3. Set strong password
4. Save

#### 2. Setup SSL/HTTPS

```bash
# Install Let's Encrypt certificate
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d yourdomain.com
```

#### 3. Configure Firewall

```bash
# Enable UFW firewall
sudo ufw enable

# Allow only necessary ports
sudo ufw allow 22/tcp    # SSH
sudo ufw allow 80/tcp    # HTTP
sudo ufw allow 443/tcp   # HTTPS
sudo ufw allow 2022/tcp  # Wings SFTP
sudo ufw allow 8080/tcp  # Wings API

# Deny all other incoming
sudo ufw default deny incoming
```

#### 4. Secure Database

```bash
# Set MySQL root password
sudo mysql_secure_installation

# Create limited privilege users
# Don't use root for applications
```

#### 5. Regular Updates

```bash
# Update system regularly
sudo apt update && sudo apt upgrade -y

# Update Pterodactyl Panel manually
cd /var/www/pterodactyl
php artisan down
# Download latest version
php artisan migrate
php artisan up
```

#### 6. Monitor Logs

```bash
# Check Panel logs
tail -f /var/www/pterodactyl/storage/logs/laravel.log

# Check Nginx logs
tail -f /var/log/nginx/error.log

# Check system logs
tail -f /var/log/auth.log
```

#### 7. Backup Regularly

```bash
#!/bin/bash
# backup.sh

# Backup database
mysqldump -u root pterodactyl > /backups/pterodactyl-$(date +%Y%m%d).sql

# Backup files
tar -czf /backups/pterodactyl-files-$(date +%Y%m%d).tar.gz /var/www/pterodactyl

# Upload to remote storage (optional)
# rsync -avz /backups/ user@remote:/backups/
```

---

## ⚠️ Known Limitations

### Current Security Limitations

1. **Default Credentials**
   - Initial password is predictable
   - **Mitigation:** Change immediately after installation

2. **No Automatic SSL**
   - SSL must be configured manually
   - **Mitigation:** Use Let's Encrypt guide

3. **Local Database**
   - Database runs on same server
   - **Mitigation:** Use remote database for production

4. **No Built-in Firewall**
   - Firewall rules not configured automatically
   - **Mitigation:** Follow firewall setup guide

5. **No Automatic Updates**
   - Panel updates must be done manually
   - **Mitigation:** Check for updates regularly

### Not Recommended For

- ❌ High-traffic production environments without additional hardening
- ❌ Multi-tenant hosting without isolation
- ❌ Storing sensitive customer data without encryption
- ❌ Mission-critical applications without backups

---

## 🔐 Security Checklist

Use this checklist to secure your installation:

### Initial Setup
- [ ] Changed default admin password
- [ ] Created separate user accounts
- [ ] Enabled SSL/HTTPS
- [ ] Configured firewall
- [ ] Secured database

### Ongoing Maintenance
- [ ] Regular system updates
- [ ] Panel updates
- [ ] Log monitoring
- [ ] Regular backups
- [ ] Access review

### Advanced Security
- [ ] Two-factor authentication (if available)
- [ ] Fail2ban installed
- [ ] Intrusion detection system
- [ ] Regular security audits
- [ ] Disaster recovery plan

---

## 📞 Security Contacts

**Report vulnerabilities to:**

- 📧 Email: satyambhaii@example.com
- 🔒 GitHub Security: https://github.com/Satyam-Bhaii/pterodactyl-installer/security
- 🐛 Issues: https://github.com/Satyam-Bhaii/pterodactyl-installer/issues

**For urgent matters, please indicate urgency in subject line.**

---

## 🙏 Security Researchers

We appreciate security researchers who help us keep users safe!

**What we appreciate:**
- ✅ Detailed vulnerability reports
- ✅ Proof-of-concept code
- ✅ Suggested fixes
- ✅ Private disclosure first

**What we don't appreciate:**
- ❌ Public disclosure before fix
- ❌ Exploiting vulnerabilities
- ❌ Accessing user data
- ❌ Disrupting services

---

## 📄 License

This security policy is part of the Pterodactyl Installer project.

**Made with ❤️ by SATYAM BHAIi**

---

```
╔═══════════════════════════════════════════════════════════╗
║     Made by SATYAM BHAIi - Pterodactyl Installer v3.0     ║
╚═══════════════════════════════════════════════════════════╝
```
