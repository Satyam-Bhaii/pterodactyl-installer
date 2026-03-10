# 🚀 SATYAM BHAIi MODERN MENU

Modern Grid Menu for Pterodactyl Installer with beautiful UI!

---

## ✨ Features

- 🎨 **Modern SEMA UI** - Beautiful gradient colors
- 📊 **System Metrics** - Live uptime & load display
- 🔒 **Root Check** - Automatic root verification
- 🌐 **Internet Check** - Connection verification
- ⚡ **Quick Actions** - One-click deployments
- 📋 **View Credentials** - Instant access to panel details
- 🔄 **Error Handling** - Automatic retry & fallback

---

## 🚀 Installation

### Method 1: Direct Run
```bash
bash <(curl -s https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/modern-menu.sh)
```

### Method 2: Download & Run
```bash
# Download
wget https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/modern-menu.sh

# Make executable
chmod +x modern-menu.sh

# Run as root
sudo ./modern-menu.sh
```

---

## 📋 Menu Options

```
┌──────────────────────────────────────────────────────────┐
│  🚀 SATYAM BHAIi PANEL MANAGER v4.0       20:30  │
└──────────────────────────────────────────────────────────┘
  SYSTEM STATUS
  ├─ Uptime : 2 hours
  └─ Load   : 0.52

────────────────────────────────────────────────────────────
  📦 AVAILABLE DEPLOYMENTS
  ┌──────────────────────────┬──────────────────────────┐
  │ [1] Pterodactyl Panel    │ [7]  Wings Daemon        │
  │ [2] SATYAM Theme 🔥      │ [8]  Auto-Configure Wings│
  │ [3] Nebula Theme         │ [9]  Quick Setup         │
  │ [4] Hyper-V Theme        │ [10] Uninstall Panel     │
  │ [5] Extensions (BP)      │ [11] View Credentials    │
  │ [6] All Extensions ⭐    │ [0] Exit                 │
  └──────────────────────────┴──────────────────────────┘

  λ Select Module [0-11]: 
```

---

## 🎯 Usage

### Install Pterodactyl Panel
```
Select: 1
```

### Install SATYAM Theme
```
Select: 2
```

### Install Wings Daemon
```
Select: 7
```

### Auto-Configure Wings
```
Select: 8
```

### View Credentials
```
Select: 11
```

---

## ✅ Automatic Checks

### Root Check
```bash
# Script automatically checks for root
✗ This script must be run as root
Run with: sudo bash modern-menu.sh
```

### Internet Check
```bash
# Script verifies internet connection
✗ No internet connection!
```

### Curl Check
```bash
# Installs curl if missing
✗ curl not found! Installing...
```

---

## 🔧 Error Handling

### Installation Failed
```bash
✗ Installation failed!
Try running manually: bash <(curl -sL URL) panel
```

### No Credentials
```bash
✗ No credentials found!
Panel may not be installed yet.
```

---

## 📁 Files

| File | Description |
|------|-------------|
| `modern-menu.sh` | Main menu script |
| `pterodactyl-installer.sh` | Main installer |
| `README.md` | Documentation |

---

## 🎨 Color Scheme

- **CYAN** - Primary actions
- **PURPLE** - Headers & borders
- **GREEN** - Success messages
- **RED** - Errors & warnings
- **GOLD** - Section titles
- **GRAY** - Secondary text

---

## 🚀 Quick Commands

### Run as Root
```bash
sudo bash modern-menu.sh
```

### Run from URL
```bash
bash <(curl -sL https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/modern-menu.sh)
```

### View Credentials Directly
```bash
cat /root/pterodactyl_credentials.txt
```

---

## 📞 Support

- **GitHub**: https://github.com/Satyam-Bhaii/pterodactyl-installer
- **Issues**: https://github.com/Satyam-Bhaii/pterodactyl-installer/issues

---

## 📄 License

MIT License - Free to use and modify!

---

**Made with ❤️ by SATYAM BHAIi** 🔥
