# 🤝 Contributing Guide

**Made by SATYAM BHAIi**

Version: 3.1

Thank you for considering contributing to Pterodactyl Installer! This guide will help you get started.

---

## 📋 Table of Contents

1. [Code of Conduct](#-code-of-conduct)
2. [How Can I Contribute?](#-how-can-i-contribute)
3. [Pull Request Process](#-pull-request-process)
4. [Coding Standards](#-coding-standards)
5. [Testing](#-testing)

---

## 📜 Code of Conduct

- Be respectful and inclusive
- Help others and be patient
- Focus on constructive feedback
- Keep discussions on-topic

---

## 🎯 How Can I Contribute?

### 🐛 Reporting Bugs

Before creating a bug report, please check:
- Existing issues (might be already reported)
- Latest version (bug might be fixed)

**When creating a bug report, include:**
- Clear title and description
- Steps to reproduce
- Expected vs actual behavior
- System information (OS, version)
- Error messages/logs

**Example:**
```markdown
**Bug Description**
Installer fails at PHP installation step

**Steps to Reproduce**
1. Run installer on Ubuntu 20.04
2. Select 'panel' option
3. Error occurs at step 3/8

**Expected Behavior**
PHP should install successfully

**Actual Behavior**
Error: Unable to locate package php8.2

**System Info**
- OS: Ubuntu 20.04
- Version: 20.04.6 LTS
- Installer: v3.0

**Logs**
E: Unable to locate package php8.2
```

### ✨ Suggesting Features

Feature suggestions are welcome! Please include:
- Clear description
- Use case
- Example usage
- Potential implementation ideas

### 📝 Improving Documentation

You can help by:
- Fixing typos
- Adding examples
- Improving clarity
- Translating to other languages

### 💻 Code Contributions

1. Fork the repository
2. Create a branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

---

## 🔄 Pull Request Process

### Before Submitting

- [ ] Code follows existing style
- [ ] Comments added where needed
- [ ] Tested on supported OS
- [ ] Documentation updated
- [ ] No sensitive information (passwords, keys, etc.)

### PR Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Code refactoring

## Testing
Tested on:
- [ ] Ubuntu 20.04
- [ ] Ubuntu 22.04
- [ ] Debian 11
- [ ] Debian 12
- [ ] Other: _____

## Checklist
- [ ] Code follows project guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] No new warnings
- [ ] Documentation updated
```

---

## 💻 Coding Standards

### Bash Script Style

```bash
# Use descriptive variable names
GOOD: PANEL_DIR="/var/www/pterodactyl"
BAD: d="/var/www/pterodactyl"

# Use functions for reusable code
function install_dependencies() {
    # Installation code
}

# Add comments for complex logic
# Check if running as root
if [[ $EUID -ne 0 ]]; then
    error "This script must be run as root"
fi

# Use colors for output
echo -e "${GREEN}✓${NC} Installation complete"
echo -e "${RED}✗${NC} Error occurred"
echo -e "${YELLOW}!${NC} Warning message"
echo -e "${BLUE}ℹ${NC} Info message"
```

### Function Structure

```bash
# Function name should be descriptive
function check_requirements() {
    # Show what's happening
    echo -e "${CYAN}Checking requirements...${NC}"
    
    # Do the check
    if [ condition ]; then
        success "Requirement met"
    else
        error "Requirement not met"
    fi
}
```

### Error Handling

```bash
# Always check for errors
command || error "Failed to execute command"

# Validate user input
if [ -z "$VARIABLE" ]; then
    error "Variable is required"
fi

# Check if file exists
if [ ! -f "/path/to/file" ]; then
    error "File not found"
fi
```

---

## 🧪 Testing

### Manual Testing

Test your changes on:
- Ubuntu 20.04, 22.04
- Debian 11, 12
- Fresh VM (no prior installations)

### Test Checklist

- [ ] Installation completes without errors
- [ ] Panel is accessible
- [ ] Admin user is created
- [ ] Database is configured
- [ ] Services are running
- [ ] Credentials are saved
- [ ] Uninstall works properly

### Common Test Scenarios

1. **Fresh Install**
   ```bash
   ./pterodactyl-installer.sh panel
   ```

2. **Custom Credentials**
   ```bash
   EMAIL=test@example.com PASSWORD=Test123 ./pterodactyl-installer.sh panel
   ```

3. **Wings Installation**
   ```bash
   ./pterodactyl-installer.sh wings
   ```

4. **Uninstall**
   ```bash
   ./pterodactyl-installer.sh uninstall
   ```

---

## 📂 File Structure

```
pterodactyl-installer/
├── pterodactyl-installer.sh    # Main installer script
├── deploy-installer.sh         # Deployment helper (optional)
├── README.md                   # Main documentation
├── INSTALLATION.md             # Installation guide
├── CONTRIBUTING.md             # This file
├── LICENSE                     # MIT License
├── .gitignore                  # Git ignore rules
└── .github/
    ├── ISSUE_TEMPLATE/         # Issue templates
    │   ├── bug_report.md
    │   └── feature_request.md
    └── PULL_REQUEST_TEMPLATE.md
```

---

## 🎨 Branding Guidelines

When making changes:

1. **Keep "Made by SATYAM BHAIi" branding**
2. **Maintain version numbers**
3. **Update changelog if adding features**
4. **Keep ASCII art logos intact**

---

## 📞 Getting Help

Need help contributing?

- 💬 Open an issue for discussion
- 📧 Contact: satyambhaii@example.com
- 📖 Read existing documentation

---

## 🏆 Contributors

Thanks to all contributors! 🎉

[View Contributors](https://github.com/Satyam-Bhaii/pterodactyl-installer/graphs/contributors)

---

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Made with ❤️ by SATYAM BHAIi**

Thank you for contributing! 🚀

---

```
╔═══════════════════════════════════════════════════════════╗
║     Made by SATYAM BHAIi - Pterodactyl Installer v3.0     ║
╚═══════════════════════════════════════════════════════════╝
```
