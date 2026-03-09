#!/bin/bash

#############################################################################
#                                                                           #
#   ██████╗  ██████╗ ██╗  ██╗   ██╗███████╗███████╗███████╗                 #
#   ██╔══██╗██╔═══██╗██║  ██║   ██║██╔════╝██╔════╝██╔════╝                 #
#   ██████╔╝██║   ██║██║  ██║   ██║█████╗  ███████╗███████╗                 #
#   ██╔═══╝ ██║   ██║██║  ╚██╗ ██╔╝██╔══╝  ╚════██║╚════██║                 #
#   ██║     ╚██████╔╝╚█████╔╚████╔╝ ███████╗███████║███████║                 #
#   ╚═╝      ╚═════╝  ╚════╝  ╚═══╝  ╚══════╝╚══════╝╚══════╝                 #
#                                                                           #
#              ██████╗ ███████╗███╗   ██╗███████╗                           #
#             ██╔════╝ ██╔════╝████╗  ██║██╔════╝                           #
#             ██║  ███╗█████╗  ██╔██╗ ██║█████╗                             #
#             ██║   ██║██╔══╝  ██║╚██╗██║██╔══╝                             #
#             ╚██████╔╝███████╗██║ ╚████║███████╗                           #
#              ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝                           #
#                                                                           #
#   ███████╗██╗███╗   ███╗██████╗ ██╗      █████╗ ████████╗███████╗███████╗ #
#   ██╔════╝██║████╗ ████║██╔══██╗██║     ██╔══██╗╚══██╔══╝██╔════╝██╔════╝ #
#   ███████╗██║██╔████╔██║██████╔╝██║     ███████║   ██║   █████╗  ███████╗ #
#   ╚════██║██║██║╚██╔╝██║██╔═══╝ ██║     ██╔══██║   ██║   ██╔══╝  ╚════██║ #
#   ███████║██║██║ ╚═╝ ██║██║     ███████╗██║  ██║   ██║   ███████╗███████║ #
#   ╚══════╝╚═╝╚═╝     ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚══════╝ #
#                                                                           #
#                    Made by SATYAM BHAIi                                   #
#                    Version: 3.0                                           #
#                                                                           #
#   GitHub: https://github.com/Satyam-Bhaii/pterodactyl-installer          #
#                                                                           #
#############################################################################

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Variables
PTERO_VERSION="1.11.8"
WINGS_VERSION="1.11.8"
PHP_VERSION="8.2"
PANEL_DIR="/var/www/pterodactyl"
WINGS_DIR="/etc/pterodactyl"
SCRIPT_VERSION="3.0"
GITHUB_REPO="https://github.com/Satyam-Bhaii/pterodactyl-installer"

# Logo function
show_logo() {
    echo -e "${CYAN}"
    cat << "EOF"
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║     ██████╗  ██████╗ ██╗  ██╗   ██╗███████╗               ║
║     ██╔══██╗██╔═══██╗██║  ██║   ██║██╔════╝               ║
║     ██████╔╝██║   ██║██║  ██║   ██║█████╗                 ║
║     ██╔═══╝ ██║   ██║██║  ╚██╗ ██╔╝██╔══╝                 ║
║     ██║     ╚██████╔╝╚█████╔╚████╔╝ ███████╗              ║
║     ╚═╝      ╚═════╝  ╚════╝  ╚═══╝  ╚══════╝              ║
║                                                           ║
║        ██████╗ ███████╗███╗   ██╗███████╗                 ║
║       ██╔════╝ ██╔════╝████╗  ██║██╔════╝                 ║
║       ██║  ███╗█████╗  ██╔██╗ ██║█████╗                   ║
║       ██║   ██║██╔══╝  ██║╚██╗██║██╔══╝                   ║
║       ╚██████╔╝███████╗██║ ╚████║███████╗                 ║
║        ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝                 ║
║                                                           ║
║              Made by SATYAM BHAIi                         ║
║              Pterodactyl Installer v${SCRIPT_VERSION}              ║
║                                                           ║
║   🌐 github.com/Satyam-Bhaii/pterodactyl-installer        ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
}

# Success message
success() {
    echo -e "${GREEN}✓${NC} $1"
}

# Error message
error() {
    echo -e "${RED}✗${NC} $1"
    exit 1
}

# Warning message
warn() {
    echo -e "${YELLOW}!${NC} $1"
}

# Info message
info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Check if running as root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        error "This script must be run as root (use sudo)"
    fi
    success "Running as root"
}

# Check OS compatibility
check_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
        VER=$VERSION_ID
        info "Detected OS: $OS $VER"
        
        case "$OS" in
            *"Ubuntu"*|*"Debian"*|*"Pop!_OS"*)
                success "Compatible OS detected"
                PKG_MANAGER="apt"
                ;;
            *"CentOS"*|*"Rocky"*|*"AlmaLinux"*|*"RHEL"*)
                success "Compatible OS detected"
                PKG_MANAGER="yum"
                ;;
            *)
                warn "OS may not be fully supported, continuing anyway..."
                PKG_MANAGER="apt"
                ;;
        esac
    else
        error "Cannot detect OS"
    fi
}

# Update system
update_system() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}[1/8]${NC} Updating system packages..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt update -y
        apt upgrade -y
    else
        yum update -y
    fi
    success "System updated"
}

# Install dependencies
install_dependencies() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}[2/8]${NC} Installing dependencies..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y software-properties-common curl wget gnupg2 \
            ca-certificates openssl git zip unzip tar lsb-release \
            apt-transport-https dialog
    else
        yum install -y epel-release yum-utils curl wget gnupg2 \
            openssl git zip unzip tar
    fi
    success "Dependencies installed"
}

# Install PHP
install_php() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}[3/8]${NC} Installing PHP ${PHP_VERSION}..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    if [ "$PKG_MANAGER" = "apt" ]; then
        add-apt-repository ppa:ondrej/php -y
        apt update
        apt install -y php${PHP_VERSION} php${PHP_VERSION}-fpm \
            php${PHP_VERSION}-mysql php${PHP_VERSION}-mbstring \
            php${PHP_VERSION}-xml php${PHP_VERSION}-zip \
            php${PHP_VERSION}-gd php${PHP_VERSION}-curl \
            php${PHP_VERSION}-intl php${PHP_VERSION}-bcmath \
            php${PHP_VERSION}-pdo php${PHP_VERSION}-tokenizer \
            php${PHP_VERSION}-fileinfo php${PHP_VERSION}-json
    else
        yum install -y remi-release
        yum install -y php php-mysqlnd php-mbstring php-xml \
            php-zip php-gd php-curl php-intl php-bcmath \
            php-pdo php-tokenizer php-fileinfo php-json php-fpm
    fi
    
    # Verify PHP version
    PHP_VER=$(php -v | head -n 1 | cut -d ' ' -f 2 | cut -d '.' -f 1,2)
    success "PHP ${PHP_VER} installed"
}

# Install Composer
install_composer() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}[4/8]${NC} Installing Composer..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    success "Composer installed"
}

# Install Node.js & Yarn
install_nodejs() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}[5/8]${NC} Installing Node.js & Yarn..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt install -y nodejs
    npm install -g yarn
    
    NODE_VER=$(node -v)
    YARN_VER=$(yarn -v)
    success "Node.js ${NODE_VER} & Yarn ${YARN_VER} installed"
}

# Install MariaDB
install_mariadb() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}[6/8]${NC} Installing MariaDB..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y mariadb-server mariadb-client
    else
        yum install -y mariadb-server mariadb
    fi
    
    systemctl enable mariadb
    systemctl start mariadb
    
    success "MariaDB installed and started"
}

# Install Docker
install_docker() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}[7/8]${NC} Installing Docker..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    systemctl enable docker
    systemctl start docker
    systemctl enable --now docker
    usermod -aG docker root
    
    success "Docker installed"
}

# Install Redis
install_redis() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}[8/8]${NC} Installing Redis..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y redis-server
    else
        yum install -y redis
    fi
    
    systemctl enable redis
    systemctl start redis
    
    success "Redis installed and started"
}

# Download Pterodactyl Panel
download_panel() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}📥${NC} Downloading Pterodactyl Panel v${PTERO_VERSION}..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    mkdir -p ${PANEL_DIR}
    cd ${PANEL_DIR}
    
    curl -Lo panel.tar.gz "https://github.com/pterodactyl/panel/releases/download/v${PTERO_VERSION}/panel.tar.gz"
    tar -xzvf panel.tar.gz
    chmod -R 755 storage/* bootstrap/cache/
    
    success "Panel downloaded"
}

# Configure Panel
configure_panel() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}⚙️${NC} Configuring Panel..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    cd ${PANEL_DIR}
    
    # Install Composer dependencies
    info "Installing Composer dependencies..."
    composer install --no-dev --optimize-autoloader
    
    # Generate encryption key
    info "Generating encryption key..."
    php artisan key:generate --force
    
    success "Panel configured"
}

# Setup Database
setup_database() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}🗄️${NC} Setting up Database..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    # Generate random password if not provided
    if [ -z "$DB_PASSWORD" ]; then
        DB_PASSWORD=$(openssl rand -base64 16)
    fi
    
    mysql -e "CREATE DATABASE IF NOT EXISTS pterodactyl;"
    mysql -e "CREATE USER IF NOT EXISTS 'pterodactyl'@'127.0.0.1' IDENTIFIED BY '${DB_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON pterodactyl.* TO 'pterodactyl'@'127.0.0.1';"
    mysql -e "FLUSH PRIVILEGES;"
    
    success "Database created"
    info "DB Password: ${DB_PASSWORD} (Save this!)"
}

# Create Admin User
create_admin_user() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}👤${NC} Creating Admin User..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    cd ${PANEL_DIR}
    
    # Set defaults if not provided
    EMAIL=${EMAIL:-"admin@satyamvps.com"}
    USERNAME=${USERNAME:-"satyam_admin"}
    FIRST_NAME=${FIRST_NAME:-"Satyam"}
    LAST_NAME=${LAST_NAME:-"Bhaii"}
    PASSWORD=${PASSWORD:-"Satyam@123"}
    
    php artisan p:user:make \
        --email="${EMAIL}" \
        --username="${USERNAME}" \
        --name-first="${FIRST_NAME}" \
        --name-last="${LAST_NAME}" \
        --password="${PASSWORD}" \
        --admin=1
    
    success "Admin user created"
    info "Email: ${EMAIL}"
    info "Username: ${USERNAME}"
    info "Password: ${PASSWORD}"
}

# Setup Web Server (Nginx)
setup_nginx() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}🌐${NC} Setting up Nginx..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    if [ "$PKG_MANAGER" = "apt" ]; then
        apt install -y nginx
    else
        yum install -y nginx
    fi
    
    # Create Nginx config
    cat > /etc/nginx/sites-available/pterodactyl.conf << 'NGINX_EOF'
server {
    listen 80;
    server_name _;
    root /var/www/pterodactyl/public;
    index index.html index.htm index.php;
    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log off;
    error_log  /var/log/nginx/pterodactyl.error.log error;

    sendfile off;

    client_max_body_size 100m;

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param PHP_VALUE "upload_max_filesize = 100M \n post_max_size=100M";
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param HTTP_PROXY "";
        fastcgi_intercept_errors off;
        fastcgi_buffer_size 16k;
        fastcgi_buffers 4 16k;
        fastcgi_connect_timeout 300;
        fastcgi_send_timeout 300;
        fastcgi_read_timeout 300;
    }

    location ~ /\.ht {
        deny all;
    }
}
NGINX_EOF

    ln -s /etc/nginx/sites-available/pterodactyl.conf /etc/nginx/sites-enabled/
    systemctl restart nginx
    systemctl enable nginx
    
    success "Nginx configured"
}

# Install Wings (Daemon)
install_wings() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}🔧${NC} Installing Wings Daemon..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    mkdir -p ${WINGS_DIR}
    cd /usr/local/bin
    
    curl -L -o wings "https://github.com/pterodactyl/wings/releases/download/v${WINGS_VERSION}/wings_linux_amd64"
    chmod +x wings
    
    success "Wings installed"
}

# Configure Wings
configure_wings() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}📋${NC} Wings Configuration..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    info "Wings configuration must be done via Panel:"
    echo "  1. Login to Panel"
    echo "  2. Go to Admin → Nodes"
    echo "  3. Create new node"
    echo "  4. Copy configuration from node settings"
    echo "  5. Paste into /etc/pterodactyl/config.yml"
    echo ""
    info "Then run: wings --config /etc/pterodactyl/config.yml"
}

# Save credentials
save_credentials() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}💾${NC} Saving Credentials..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    cat > /root/pterodactyl_credentials.txt << EOF
╔═══════════════════════════════════════════════════════════╗
║     PTERODACTYL PANEL CREDENTIALS                         ║
║     Made by SATYAM BHAIi                                  ║
║     v${SCRIPT_VERSION}                                              ║
╚═══════════════════════════════════════════════════════════╝

Panel Information:
------------------
Panel URL: http://$(hostname -I | awk '{print $1}')
Panel Directory: ${PANEL_DIR}

Admin Credentials:
------------------
Email: ${EMAIL}
Username: ${USERNAME}
Password: ${PASSWORD}

Database Information:
---------------------
Database: pterodactyl
Username: pterodactyl
Password: ${DB_PASSWORD}
Host: 127.0.0.1
Port: 3306

Wings Information:
------------------
Wings Directory: ${WINGS_DIR}
Config File: ${WINGS_DIR}/config.yml

Important Commands:
-------------------
Start Panel: cd ${PANEL_DIR} && php artisan serve --host=0.0.0.0 --port=8000
Start Wings: wings --config /etc/pterodactyl/config.yml
View Logs: tail -f ${PANEL_DIR}/storage/logs/laravel.log

Services:
---------
Nginx: systemctl status nginx
MariaDB: systemctl status mariadb
Redis: systemctl status redis
Docker: systemctl status docker
PHP-FPM: systemctl status php${PHP_VERSION}-fpm

🌐 GitHub: ${GITHUB_REPO}

╔═══════════════════════════════════════════════════════════╗
║     Made by SATYAM BHAIi - Share & Enjoy!                 ║
╚═══════════════════════════════════════════════════════════╝
EOF

    success "Credentials saved to /root/pterodactyl_credentials.txt"
    chmod 600 /root/pterodactyl_credentials.txt
}

# Main installation function
install_panel() {
    show_logo
    
    echo -e "${YELLOW}Starting Pterodactyl Panel Installation...${NC}\n"
    
    check_root
    check_os
    update_system
    install_dependencies
    install_php
    install_composer
    install_nodejs
    install_mariadb
    install_docker
    install_redis
    download_panel
    setup_database
    configure_panel
    create_admin_user
    setup_nginx
    save_credentials
    
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║   ✅ PANEL INSTALLATION COMPLETE!             ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════╝${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    info "Panel URL: http://$(hostname -I | awk '{print $1}')"
    info "Credentials saved to: /root/pterodactyl_credentials.txt"
    info "GitHub: ${GITHUB_REPO}"
    info "Made by SATYAM BHAIi"
    
    echo -e "\n${YELLOW}Next Steps:${NC}"
    echo "  1. Configure Nginx with your domain"
    echo "  2. Setup SSL with Let's Encrypt"
    echo "  3. Install Wings on separate server/node"
    echo "  4. Create game servers from panel"
    echo ""
    echo -e "${CYAN}🌐 Star us on GitHub: ${GITHUB_REPO}${NC}"
}

# Install Wings only
install_wings_only() {
    show_logo
    
    echo -e "${YELLOW}Starting Wings Daemon Installation...${NC}\n"
    
    check_root
    check_os
    update_system
    install_docker
    install_wings
    
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║   ✅ WINGS INSTALLATION COMPLETE!             ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════╝${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    info "Wings installed at: /usr/local/bin/wings"
    info "Config directory: /etc/pterodactyl"
    info "GitHub: ${GITHUB_REPO}"
    
    configure_wings
}

# Quick setup (Panel + Wings on same server)
quick_setup() {
    show_logo
    
    echo -e "${YELLOW}Starting Quick Setup (Panel + Wings)...${NC}\n"
    
    install_panel
    install_wings_only
    
    echo -e "\n${GREEN}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║   ✅ QUICK SETUP COMPLETE!                    ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════╝${NC}\n"
    
    info "Panel & Wings installed successfully!"
    info "GitHub: ${GITHUB_REPO}"
    info "Made by SATYAM BHAIi"
}

# Uninstall Pterodactyl
uninstall() {
    show_logo
    
    echo -e "${RED}Starting Uninstallation...${NC}\n"
    
    warn "This will remove Pterodactyl Panel and Wings!"
    read -p "Are you sure? (y/N): " confirm
    
    if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
        # Stop services
        systemctl stop nginx 2>/dev/null
        systemctl stop mariadb 2>/dev/null
        systemctl stop redis 2>/dev/null
        systemctl stop docker 2>/dev/null
        
        # Remove files
        rm -rf ${PANEL_DIR}
        rm -rf ${WINGS_DIR}
        rm -f /usr/local/bin/wings
        rm -f /etc/nginx/sites-available/pterodactyl.conf
        rm -f /etc/nginx/sites-enabled/pterodactyl.conf
        
        # Remove database
        mysql -e "DROP DATABASE IF EXISTS pterodactyl;"
        mysql -e "DROP USER IF EXISTS 'pterodactyl'@'127.0.0.1';"
        
        success "Pterodactyl uninstalled"
        info "GitHub: ${GITHUB_REPO}"
        info "Made by SATYAM BHAIi"
    else
        info "Uninstallation cancelled"
    fi
}

# Show help
show_help() {
    show_logo
    
    echo -e "${CYAN}Usage:${NC} $0 [command]"
    echo ""
    echo -e "${CYAN}Commands:${NC}"
    echo "  panel          - Install Pterodactyl Panel only"
    echo "  wings          - Install Wings Daemon only"
    echo "  quick          - Quick setup (Panel + Wings)"
    echo "  uninstall      - Remove Pterodactyl"
    echo "  help           - Show this help message"
    echo ""
    echo -e "${CYAN}Environment Variables:${NC}"
    echo "  EMAIL          - Admin email (default: admin@satyamvps.com)"
    echo "  USERNAME       - Admin username (default: satyam_admin)"
    echo "  PASSWORD       - Admin password (default: Satyam@123)"
    echo "  DB_PASSWORD    - Database password (auto-generated if not set)"
    echo ""
    echo -e "${CYAN}Examples:${NC}"
    echo "  $0 panel"
    echo "  EMAIL=admin@example.com PASSWORD=MyPass123 $0 panel"
    echo "  $0 wings"
    echo "  $0 quick"
    echo ""
    echo -e "${CYAN}🌐 GitHub:${NC} ${GITHUB_REPO}"
    echo -e "${BLUE}Made by SATYAM BHAIi${NC}"
    echo -e "${BLUE}Version: ${SCRIPT_VERSION}${NC}"
}

# Main menu
main_menu() {
    show_logo
    
    echo -e "${YELLOW}Select an option:${NC}"
    echo ""
    echo "  1) Install Pterodactyl Panel"
    echo "  2) Install Wings Daemon"
    echo "  3) Quick Setup (Panel + Wings)"
    echo "  4) Uninstall Pterodactyl"
    echo "  5) Exit"
    echo ""
    read -p "Enter choice [1-5]: " choice
    
    case $choice in
        1) install_panel ;;
        2) install_wings_only ;;
        3) quick_setup ;;
        4) uninstall ;;
        5) exit 0 ;;
        *) error "Invalid option" ;;
    esac
}

# Parse command line arguments
case "${1:-menu}" in
    panel)
        install_panel
        ;;
    wings)
        install_wings_only
        ;;
    quick)
        quick_setup
        ;;
    uninstall)
        uninstall
        ;;
    help|--help|-h)
        show_help
        ;;
    menu)
        main_menu
        ;;
    *)
        error "Unknown command: $1. Use 'help' for usage."
        ;;
esac
