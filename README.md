# 🦅 Pterodactyl Panel Installer

```

┏━┓┏━┓╺┳╸╻ ╻┏━┓┏┳┓   ┏┓ ╻ ╻┏━┓╻╻
┗━┓┣━┫ ┃ ┗┳┛┣━┫┃┃┃   ┣┻┓┣━┫┣━┫┃┃
┗━┛╹ ╹ ╹  ╹ ╹ ╹╹ ╹   ┗━┛╹ ╹╹ ╹╹╹

```

**Made by SATYAM BHAIi** | Version: 4.0 (Modern UI)

[![GitHub stars](https://img.shields.io/github/stars/Satyam-Bhaii/pterodactyl-installer?style=for-the-badge)](https://github.com/Satyam-Bhaii/pterodactyl-installer/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/Satyam-Bhaii/pterodactyl-installer?style=for-the-badge)](https://github.com/Satyam-Bhaii/pterodactyl-installer/network)
[![GitHub issues](https://img.shields.io/github/issues/Satyam-Bhaii/pterodactyl-installer?style=for-the-badge)](https://github.com/Satyam-Bhaii/pterodactyl-installer/issues)
[![License](https://img.shields.io/github/license/Satyam-Bhaii/pterodactyl-installer?style=for-the-badge)](https://github.com/Satyam-Bhaii/pterodactyl-installer/blob/main/LICENSE)

---

## 🚀 Quick Install

### 🔥 One-Command Installation

```bash
bash <(curl -s https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh)
```

**That's it!** Interactive menu mein se option select karo aur bas! ✨

---

## ✨ What's New in v4.0? (Modern UI Update)

- 🎨 **Completely Redes UI** - Modern box-style interface
- 🌈 **Colorful Messages** - Beautiful colored output
- 📦 **Box-Style Prompts** - Professional looking input boxes
- ✨ **Enhanced Logo** - Stylish ASCII art with colors
- 🎯 **Smart Defaults** - Auto-fill common values
- 🔄 **Better Validation** - Real-time input checking
- 📊 **Progress Indicators** - Know what's happening
- 🎭 **Modern Icons** - Emoji-based visual cues

### 📥 Download & Install

```bash
wget https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh
chmod +x pterodactyl-installer.sh
sudo ./pterodactyl-installer.sh
```

### 🌐 GitHub Pages URL (Jab enable ho)

```bash
bash <(curl -s https://satyam-bhaii.github.io/pterodactyl-installer/pterodactyl-installer.sh)
```

---

## 📋 Commands

| Command | Description |
|---------|-------------|
| `panel` | Install Pterodactyl Panel only |
| `wings` | Install Wings Daemon only |
| `quick` | Quick setup (Panel + Wings together) |
| `configure` | **NEW!** Auto-configure Wings with UUID/Token |
| `uninstall` | Remove Pterodactyl completely |
| `help` | Show help message |

### Examples

```bash
# Install Panel only
sudo ./pterodactyl-installer.sh panel

# Install Wings only
sudo ./pterodactyl-installer.sh wings

# Auto-configure Wings (NEW!)
sudo ./pterodactyl-installer.sh configure

# Quick setup everything
sudo ./pterodactyl-installer.sh quick

# Uninstall
sudo ./pterodactyl-installer.sh uninstall

# Show help
./pterodactyl-installer.sh help
```

---

## 🎮 Features

### Panel Installation
- ✅ Automatic system update
- ✅ PHP 8.2 with all extensions
- ✅ Composer & Node.js installation
- ✅ MariaDB database setup
- ✅ Redis cache server
- ✅ Docker container runtime
- ✅ Nginx web server configuration
- ✅ Auto admin user creation
- ✅ Credentials saved securely

### Wings Daemon
- ✅ Docker installation
- ✅ Wings binary download
- ✅ Configuration template
- ✅ Systemd service ready

### Security
- ✅ Root check
- ✅ OS compatibility check
- ✅ Secure password generation
- ✅ Credential file with restricted permissions

---

## 📦 Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| **OS** | Ubuntu 20.04 / Debian 11 | Ubuntu 22.04 / Debian 12 |
| **RAM** | 2 GB | 4 GB+ |
| **Storage** | 10 GB | 20 GB+ |
| **CPU** | 2 cores | 4 cores+ |

### Supported OS
- Ubuntu 20.04, 22.04, 24.04
- Debian 11, 12
- CentOS 8, 9
- Rocky Linux 8, 9
- AlmaLinux 8, 9

---

## 🌐 Deploy to Web Server

Apne installer ko web par host karo taaki users single command se install kar sakein:

```bash
# Deploy script run karo
./deploy-installer.sh
```

### Free Hosting Options

1. **GitHub Pages**
   ```bash
   # URL: https://USERNAME.github.io/repo/pterodactyl-installer.sh
   ```

2. **Netlify**
   ```bash
   # URL: https://SITE-NAME.netlify.app/pterodactyl-installer.sh
   ```

3. **Vercel**
   ```bash
   # URL: https://PROJECT.vercel.app/pterodactyl-installer.sh
   ```

### Users ke liye installation command:

```bash
bash <(curl -s https://YOUR-URL-HERE/pterodactyl-installer.sh)
```

---

## 📁 File Structure

```
pterodactyl-installer/
├── pterodactyl-installer.sh    # Main installer script
├── deploy-installer.sh         # Deployment helper
├── README.md                   # This file
└── pterodactyl-installer-deploy/
    ├── pterodactyl-installer.sh
    ├── README.md
    └── index.html
```

---

## 🔧 Post-Installation

### Panel Access
```bash
# Panel URL
http://YOUR-SERVER-IP

# Default credentials (change immediately!)
Email: admin@satyamvps.com
Username: satyam_admin
Password: Satyam@123
```

### Credentials Location
```bash
cat /root/pterodactyl_credentials.txt
```

### Useful Commands

```bash
# Start Panel manually
cd /var/www/pterodactyl && php artisan serve --host=0.0.0.0 --port=8000

# Start Wings
wings --config /etc/pterodactyl/config.yml

# View Panel logs
tail -f /var/www/pterodactyl/storage/logs/laravel.log

# Service management
systemctl status nginx
systemctl status mariadb
systemctl status redis
systemctl status docker
systemctl status php8.2-fpm
```

---

## 🎯 Setup Game Servers

1. Login to Panel
2. Go to **Admin → Nodes**
3. Click **Create New Node**
4. Configure node settings
5. Copy configuration to Wings server
6. Start Wings: `wings --config /etc/pterodactyl/config.yml`
7. Create servers from panel!

### Supported Games
- 🎮 Minecraft (Java & Bedrock)
- 🎮 GTA V (FiveM, RageMP, Alt:V)
- 🎮 Rust
- 🎮 ARK: Survival Evolved
- 🎮 Terraria
- 🎮 CS:GO
- 🎮 Valheim
- 🎮 +50 more via eggs!

---

## ⚠️ Important Notes

- **Production Use**: Proper VPS with static IP recommended
- **Security**: Change default passwords immediately
- **SSL**: Setup Let's Encrypt for HTTPS
- **Backup**: Regular database backups lete rahein
- **Updates**: Panel updates manually karna hoga

---

## 🐛 Troubleshooting

### Panel not accessible
```bash
# Check if services are running
systemctl status nginx
systemctl status php8.2-fpm

# Check firewall
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 8000/tcp
```

### Database connection error
```bash
# Verify credentials
cat /root/pterodactyl_credentials.txt

# Test MySQL connection
mysql -u pterodactyl -p
```

### Wings not connecting
```bash
# Check config
cat /etc/pterodactyl/config.yml

# Restart Wings
systemctl restart wings
```

---

## 📞 Support

**Made by SATYAM BHAIi**

- 📧 Email: satyambhaii@example.com
- 💬 Telegram: @satyambhaii
- 🌐 GitHub: github.com/satyambhaii

---

## 📄 License

Free to use, modify and distribute!

**Made with ❤️ by SATYAM BHAIi**

Share & Enjoy! 🎉

---

## 🙏 Credits

- Pterodactyl Panel: https://pterodactyl.io
- Made by SATYAM BHAIi
- Original concept: Pterodactyl Team

---

```
╔═══════════════════════════════════════════════════════════╗
║     Made by SATYAM BHAIi - Pterodactyl Installer v2.0     ║
╚═══════════════════════════════════════════════════════════╝
```
