#!/bin/bash

#############################################################################
#                                                                           #
#              🌐 Deploy Installer to Web Server                            #
#              Made by SATYAM BHAIi                                         #
#                                                                           #
#############################################################################

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║     🚀 Deploy Installer to Web Server                     ║"
echo "║     Made by SATYAM BHAIi                                  ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if running on Linux/Mac
if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]]; then
    success "Compatible OS detected"
else
    error "This deploy script works on Linux/Mac only"
fi

echo ""
echo -e "${YELLOW}Select deployment method:${NC}"
echo ""
echo "  1) GitHub Pages (Free)"
echo "  2) Netlify (Free)"
echo "  3) Vercel (Free)"
echo "  4) Your own web server"
echo "  5) Create deployment package"
echo ""
read -p "Enter choice [1-5]: " deploy_choice

case $deploy_choice in
    1)
        echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${BLUE}📦 GitHub Pages Deployment${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
        
        echo "Steps to deploy on GitHub Pages:"
        echo ""
        echo "  1. Create a new repository on GitHub"
        echo "  2. Clone it: git clone https://github.com/YOUR_USERNAME/pterodactyl-installer.git"
        echo "  3. Copy pterodactyl-installer.sh to that folder"
        echo "  4. Run these commands:"
        echo ""
        echo -e "${YELLOW}     cd pterodactyl-installer${NC}"
        echo -e "${YELLOW}     git add .${NC}"
        echo -e "${YELLOW}     git commit -m 'Initial commit - Made by SATYAM BHAIi'${NC}"
        echo -e "${YELLOW}     git push -u origin main${NC}"
        echo ""
        echo "  5. Go to Settings → Pages"
        echo "  6. Select branch: main, folder: / (root)"
        echo "  7. Save and wait for deployment"
        echo ""
        echo "  Your installer URL will be:"
        echo -e "${GREEN}  https://YOUR_USERNAME.github.io/pterodactyl-installer/pterodactyl-installer.sh${NC}"
        echo ""
        echo "  Installation command for users:"
        echo -e "${CYAN}  bash <(curl -s https://YOUR_USERNAME.github.io/pterodactyl-installer/pterodactyl-installer.sh)${NC}"
        ;;
        
    2)
        echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${BLUE}📦 Netlify Deployment${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
        
        echo "Steps to deploy on Netlify:"
        echo ""
        echo "  1. Create account on https://netlify.com"
        echo "  2. Create a folder with pterodactyl-installer.sh"
        echo "  3. Drag & drop the folder to Netlify"
        echo "  4. Or connect GitHub repository"
        echo ""
        echo "  Your installer URL will be:"
        echo -e "${GREEN}  https://YOUR-SITE-NAME.netlify.app/pterodactyl-installer.sh${NC}"
        echo ""
        echo "  Installation command for users:"
        echo -e "${CYAN}  bash <(curl -s https://YOUR-SITE-NAME.netlify.app/pterodactyl-installer.sh)${NC}"
        ;;
        
    3)
        echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${BLUE}📦 Vercel Deployment${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
        
        echo "Steps to deploy on Vercel:"
        echo ""
        echo "  1. Create account on https://vercel.com"
        echo "  2. Install Vercel CLI: npm i -g vercel"
        echo "  3. Navigate to folder with installer script"
        echo "  4. Run: vercel"
        echo "  5. Follow prompts"
        echo ""
        echo "  Your installer URL will be:"
        echo -e "${GREEN}  https://YOUR-PROJECT.vercel.app/pterodactyl-installer.sh${NC}"
        echo ""
        echo "  Installation command for users:"
        echo -e "${CYAN}  bash <(curl -s https://YOUR-PROJECT.vercel.app/pterodactyl-installer.sh)${NC}"
        ;;
        
    4)
        echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${BLUE}📦 Your Own Web Server${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
        
        read -p "Enter your web server path (e.g., /var/www/html): " web_path
        web_path=${web_path:-"/var/www/html"}
        
        cp pterodactyl-installer.sh "${web_path}/"
        chmod +x "${web_path}/pterodactyl-installer.sh"
        
        echo -e "\n${GREEN}✓${NC} Installer deployed to: ${web_path}/pterodactyl-installer.sh"
        echo ""
        echo "  Your installer URL will be:"
        echo -e "${GREEN}  http://YOUR-IP/pterodactyl-installer.sh${NC}"
        echo ""
        echo "  Installation command for users:"
        echo -e "${CYAN}  bash <(curl -s http://YOUR-IP/pterodactyl-installer.sh)${NC}"
        ;;
        
    5)
        echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${BLUE}📦 Creating Deployment Package${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
        
        # Create deployment folder
        DEPLOY_DIR="pterodactyl-installer-deploy"
        mkdir -p "${DEPLOY_DIR}"
        
        # Copy installer
        cp pterodactyl-installer.sh "${DEPLOY_DIR}/"
        
        # Create README
        cat > "${DEPLOY_DIR}/README.md" << 'EOF'
# 🦅 Pterodactyl Panel Installer

**Made by SATYAM BHAIi**

Easy one-command installer for Pterodactyl Panel and Wings.

## 🚀 Quick Install

```bash
bash <(curl -s https://YOUR-URL-HERE/pterodactyl-installer.sh)
```

## 📋 Commands

- `panel` - Install Panel only
- `wings` - Install Wings only
- `quick` - Quick setup (Panel + Wings)
- `uninstall` - Remove Pterodactyl
- `help` - Show help

## 🎮 Features

✅ Automatic dependencies installation
✅ PHP 8.2 with all extensions
✅ MariaDB database setup
✅ Docker & Redis installation
✅ Nginx web server configuration
✅ Admin user creation
✅ Wings daemon support

## 📞 Support

Made by SATYAM BHAIi

## 📄 License

Free to use and modify!
EOF

        # Create index.html for web servers
        cat > "${DEPLOY_DIR}/index.html" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pterodactyl Installer - Made by SATYAM BHAIi</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            text-align: center;
        }
        h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            background: linear-gradient(90deg, #00d9ff, #00ff88);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .subtitle {
            font-size: 1.2em;
            color: #888;
            margin-bottom: 30px;
        }
        .install-box {
            background: rgba(255,255,255,0.1);
            border-radius: 15px;
            padding: 30px;
            margin: 20px 0;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
        }
        .command {
            background: #0d1117;
            padding: 20px;
            border-radius: 10px;
            font-family: 'Courier New', monospace;
            font-size: 1.1em;
            color: #00ff88;
            margin: 15px 0;
            overflow-x: auto;
        }
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin: 30px 0;
        }
        .feature {
            background: rgba(255,255,255,0.05);
            padding: 20px;
            border-radius: 10px;
            border: 1px solid rgba(255,255,255,0.1);
        }
        .feature-icon {
            font-size: 2em;
            margin-bottom: 10px;
        }
        .btn {
            display: inline-block;
            padding: 15px 30px;
            background: linear-gradient(90deg, #00d9ff, #00ff88);
            color: #1a1a2e;
            text-decoration: none;
            border-radius: 30px;
            font-weight: bold;
            margin: 10px;
            transition: transform 0.3s;
        }
        .btn:hover {
            transform: scale(1.05);
        }
        .footer {
            margin-top: 40px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🦅 Pterodactyl Installer</h1>
        <p class="subtitle">Made by SATYAM BHAIi</p>
        
        <div class="install-box">
            <h2>🚀 One-Command Installation</h2>
            <div class="command">bash <(curl -s https://YOUR-URL-HERE/pterodactyl-installer.sh)</div>
            <a href="pterodactyl-installer.sh" class="btn" download>📥 Download Installer</a>
        </div>
        
        <div class="features">
            <div class="feature">
                <div class="feature-icon">📊</div>
                <h3>Panel</h3>
                <p>Full Pterodactyl Panel</p>
            </div>
            <div class="feature">
                <div class="feature-icon">🔧</div>
                <h3>Wings</h3>
                <p>Server Daemon</p>
            </div>
            <div class="feature">
                <div class="feature-icon">🐘</div>
                <h3>PHP 8.2</h3>
                <p>Latest Version</p>
            </div>
            <div class="feature">
                <div class="feature-icon">🗄️</div>
                <h3>MariaDB</h3>
                <p>Database Included</p>
            </div>
            <div class="feature">
                <div class="feature-icon">🐳</div>
                <h3>Docker</h3>
                <p>Container Support</p>
            </div>
            <div class="feature">
                <div class="feature-icon">🔐</div>
                <h3>Secure</h3>
                <p>Auto Configuration</p>
            </div>
        </div>
        
        <div class="footer">
            <p>Made with ❤️ by SATYAM BHAIi</p>
        </div>
    </div>
</body>
</html>
EOF

        # Create zip package
        if command -v zip &> /dev/null; then
            cd "${DEPLOY_DIR}"
            zip -r ../pterodactyl-installer-package.zip .
            cd ..
            echo -e "\n${GREEN}✓${NC} Package created: pterodactyl-installer-package.zip"
        fi
        
        echo -e "\n${GREEN}✓${NC} Deployment package created in: ${DEPLOY_DIR}/"
        echo ""
        echo "Files created:"
        echo "  - ${DEPLOY_DIR}/pterodactyl-installer.sh"
        echo "  - ${DEPLOY_DIR}/README.md"
        echo "  - ${DEPLOY_DIR}/index.html"
        if [ -f "pterodactyl-installer-package.zip" ]; then
            echo "  - pterodactyl-installer-package.zip"
        fi
        echo ""
        echo "Upload the contents of '${DEPLOY_DIR}' to your web server!"
        ;;
        
    *)
        echo -e "${RED}✗${NC} Invalid option"
        exit 1
        ;;
esac

echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Made by SATYAM BHAIi${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
