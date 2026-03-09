# 🚀 Complete Installation Guide

**Made by SATYAM BHAIi** | Pterodactyl Installer v3.1

---

## 📋 Table of Contents

1. [Quick Start](#-quick-start)
2. [Prerequisites](#-prerequisites)
3. [Installation Methods](#-installation-methods)
4. [Post-Installation](#-post-installation)
5. [Configuration](#-configuration)
6. [Troubleshooting](#-troubleshooting)
7. [FAQ](#-faq)

---

## ⚡ Quick Start

### One-Line Installation

```bash
bash <(curl -s https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh)
```

**That's it!** The installer will:
- ✅ Install all dependencies
- ✅ Setup MariaDB database
- ✅ Configure Nginx web server
- ✅ Install Pterodactyl Panel
- ✅ Create admin user
- ✅ Save credentials

---

## 📦 Prerequisites

### System Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| **OS** | Ubuntu 20.04 / Debian 11 | Ubuntu 22.04 / Debian 12 |
| **RAM** | 2 GB | 4 GB+ |
| **CPU** | 2 cores | 4 cores+ |
| **Storage** | 10 GB | 20 GB+ SSD |
| **Network** | 100 Mbps | 1 Gbps |

### Supported Operating Systems

- ✅ Ubuntu 20.04, 22.04, 24.04
- ✅ Debian 11 (Bullseye), 12 (Bookworm)
- ✅ CentOS 8, 9
- ✅ Rocky Linux 8, 9
- ✅ AlmaLinux 8, 9
- ✅ Pop!_OS

### Required Ports

| Port | Service |
|------|---------|
| 80 | HTTP (Web) |
| 443 | HTTPS (Web with SSL) |
| 22 | SSH |
| 2022 | Wings SFTP |
| 8080 | Wings API |
| 3306 | MySQL (Internal) |

---

## 💾 Installation Methods

### Method 1: One-Command Install (Recommended)

```bash
bash <(curl -s https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh)
```

**Steps:**
1. Copy the command above
2. Paste in terminal (as root)
3. Wait for installation (~10-15 minutes)
4. Note down the credentials!

---

### Method 2: Download & Install

```bash
# Download the installer
wget https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh

# Make it executable
chmod +x pterodactyl-installer.sh

# Run as root
sudo ./pterodactyl-installer.sh
```

---

### Method 3: Git Clone

```bash
# Clone the repository
git clone https://github.com/Satyam-Bhaii/pterodactyl-installer.git
cd pterodactyl-installer

# Run installer
sudo ./pterodactyl-installer.sh
```

---

### Method 4: Custom Installation

```bash
# Panel only (for main server)
sudo ./pterodactyl-installer.sh panel

# Wings only (for game nodes)
sudo ./pterodactyl-installer.sh wings

# Quick setup (both on same server)
sudo ./pterodactyl-installer.sh quick
```

---

### Method 5: With Custom Credentials

```bash
EMAIL=admin@example.com \
USERNAME=admin \
PASSWORD=SecurePass123 \
sudo ./pterodactyl-installer.sh panel
```

---

## 🎯 Post-Installation

### 1. Access Panel

After installation, you'll see:
```
Panel URL: http://YOUR_SERVER_IP
Email: admin@satyamvps.com
Username: satyam_admin
Password: Satyam@123
```

Open browser and go to: `http://YOUR_SERVER_IP`

### 2. View Saved Credentials

```bash
cat /root/pterodactyl_credentials.txt
```

### 3. Change Default Password

**IMPORTANT:** Change password immediately after first login!

1. Login to panel
2. Go to Account → Password
3. Enter new password
4. Save

### 4. Setup SSL (Recommended)

```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx

# Get SSL certificate
sudo certbot --nginx -d yourdomain.com

# Auto-renewal is automatic
```

---

## ⚙️ Configuration

### Setup Wings (Game Server Node)

1. **Login to Panel**
2. **Go to:** Admin → Nodes
3. **Click:** Create New
4. **Fill in:**
   - Name: `satyam-node-1`
   - Location: Your location
   - FQDN: `your-domain.com`
   - Public IP: Your server IP
   - Ports: 8080, 2022
5. **Save**
6. **Copy Configuration**
7. **On Wings server:**
   ```bash
   nano /etc/pterodactyl/config.yml
   # Paste configuration
   # Save (Ctrl+X, Y, Enter)
   
   # Start Wings
   wings --config /etc/pterodactyl/config.yml
   ```

### Create First Server

1. **Go to:** Admin → Servers
2. **Click:** Create New
3. **Fill in:**
   - Name: My Minecraft Server
   - User: Select user
   - Egg: Minecraft (Java Edition)
   - Docker Image: Select appropriate
4. **Configure:**
   - Memory: 2048 MB
   - CPU: 100%
   - Disk: 10 GB
   - Ports: Add port
5. **Create Server**

---

## 🐛 Troubleshooting

### Panel Not Accessible

```bash
# Check if services are running
sudo systemctl status nginx
sudo systemctl status php8.2-fpm

# Restart services
sudo systemctl restart nginx
sudo systemctl restart php8.2-fpm

# Check firewall
sudo ufw status
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

### Database Connection Error

```bash
# Check MariaDB status
sudo systemctl status mariadb

# Restart MariaDB
sudo systemctl restart mariadb

# Verify credentials
cat /root/pterodactyl_credentials.txt
```

### Wings Not Connecting

```bash
# Check Wings status
sudo systemctl status wings

# View Wings logs
sudo tail -f /var/log/pterodactyl/wings.log

# Restart Wings
sudo systemctl restart wings
```

### Docker Issues

```bash
# Check Docker status
sudo systemctl status docker

# Restart Docker
sudo systemctl restart docker

# Test Docker
sudo docker run hello-world
```

### PHP Errors

```bash
# Check PHP-FPM status
sudo systemctl status php8.2-fpm

# View logs
sudo tail -f /var/log/php8.2-fpm.log

# Restart PHP-FPM
sudo systemctl restart php8.2-fpm
```

---

## ❓ FAQ

### Q: Is this free?
**A:** Yes! Completely free and open source.

### Q: Can I use this for production?
**A:** Yes, but we recommend:
- Using a proper VPS with static IP
- Setting up SSL/HTTPS
- Regular backups
- Strong passwords

### Q: How long does installation take?
**A:** Approximately 10-15 minutes depending on internet speed.

### Q: Can I install on localhost?
**A:** Yes, but you'll need port forwarding for external access.

### Q: What games are supported?
**A:** 50+ games including:
- Minecraft (Java & Bedrock)
- GTA V (FiveM, RageMP)
- Rust, ARK, Terraria
- CS:GO, Valheim
- And many more!

### Q: How to update Panel?
**A:** Manual update required:
```bash
cd /var/www/pterodactyl
php artisan down
# Download new version
composer install --no-dev --optimize-autoloader
php artisan migrate
php artisan config:clear
php artisan up
```

### Q: Can I install multiple nodes?
**A:** Yes! Install Panel on one server and Wings on multiple servers.

### Q: Where are server files stored?
**A:** `/var/lib/pterodactyl/volumes/`

### Q: How to backup?
**A:** 
```bash
# Backup database
mysqldump -u root pterodactyl > backup.sql

# Backup files
tar -czf ptero-backup.tar.gz /var/www/pterodactyl
```

---

## 📞 Support

### Need Help?

- 📖 **Documentation:** https://pterodactyl.io
- 💬 **GitHub Issues:** https://github.com/Satyam-Bhaii/pterodactyl-installer/issues
- 📧 **Contact:** satyambhaii@example.com

### Useful Links

- Pterodactyl Official: https://pterodactyl.io
- Discord: https://discord.gg/pterodactyl
- Community Forum: https://community.pterodactyl.dev

---

## 🎉 You're Done!

Your Pterodactyl Panel is now ready to use! 🚀

**Start creating game servers and enjoy!**

---

**Made with ❤️ by SATYAM BHAIi**

[GitHub](https://github.com/Satyam-Bhaii/pterodactyl-installer) • [Report Issue](https://github.com/Satyam-Bhaii/pterodactyl-installer/issues) • [Donate](#)

---

```
╔═══════════════════════════════════════════════════════════╗
║     Made by SATYAM BHAIi - Pterodactyl Installer v3.0     ║
╚═══════════════════════════════════════════════════════════╝
```
