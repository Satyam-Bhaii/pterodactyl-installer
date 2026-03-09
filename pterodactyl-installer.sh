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
#                    Version: 4.0 (Modern UI)                               #
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
SCRIPT_VERSION="4.0"
GITHUB_REPO="https://github.com/Satyam-Bhaii/pterodactyl-installer"

# Logo function
show_logo() {
    echo -e "${CYAN}"
    echo ""
    echo "┏━┓┏━┓╺┳╸╻ ╻┏━┓┏┳┓   ┏┓ ╻ ╻┏━┓╻╻"
    echo "┗━┓┣━┫ ┃ ┗┳┛┣━┫┃┃┃   ┣┻┓┣━┫┣━┫┃┃"
    echo "┗━┛╹ ╹ ╹  ╹ ╹ ╹╹ ╹   ┗━┛╹ ╹╹ ╹╹╹"
    echo ""
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║     Made by SATYAM BHAIi - Pterodactyl Installer          ║"
    echo "║     Version: ${SCRIPT_VERSION}                                          ║"
    echo "║     GitHub: Satyam-Bhaii/pterodactyl-installer            ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}  The Ultimate Pterodactyl Installer${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
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
    
    echo -e "${YELLOW}Select configuration method:${NC}"
    echo ""
    echo "  1) Auto Configure (Recommended) - Just enter details from Panel"
    echo "  2) Manual Configure - Paste config.yml manually"
    echo "  3) Skip - Configure later"
    echo ""
    read -p "Enter choice [1-3]: " config_choice
    
    case $config_choice in
        1)
            auto_configure_wings
            ;;
        2)
            manual_configure_wings
            ;;
        3)
            info "You can configure later by running: wings configure"
            ;;
        *)
            error "Invalid option"
            ;;
    esac
}

# Auto Configure Wings
auto_configure_wings() {
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}🔧 Wings Configuration${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "  ${GREEN}1${NC}) Auto-Configure (Interactive)"
    echo -e "  ${GREEN}2${NC}) Auto-Deploy (One Command with Token) ${YELLOW}⚡${NC}"
    echo -e "  ${GREEN}0${NC}) Back to Main Menu"
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    read -p "${CYAN}❯${NC} Select configuration method [0-2]: " config_method
    echo ""
    
    case $config_method in
        1) interactive_configure_wings ;;
        2) onecommand_deploy_wings ;;
        0) main_menu ;;
        *) echo -e "${RED}❌ Invalid option.${NC}\n"; auto_configure_wings ;;
    esac
}

interactive_configure_wings() {
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}🔧 Auto Configure Wings${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    info "Get details from Panel: Admin → Nodes → Your Node → Configuration"
    echo -e "${YELLOW}💡 Tip: Open Panel in another tab and copy-paste!${NC}\n"
    
    # Get configuration details
    read -p "${CYAN}❯${NC} Panel URL (e.g., https://panel.example.com): " PANEL_URL
    read -p "${CYAN}❯${NC} Node UUID: " NODE_UUID
    read -p "${CYAN}❯${NC} Token ID: " TOKEN_ID
    read -p "${CYAN}❯${NC} Token (Secret): " TOKEN
    
    # Port configuration with defaults
    echo -e "\n${YELLOW}Port Configuration (press Enter for defaults):${NC}"
    read -p "${CYAN}❯${NC} Wings API Port [8080]: " WINGS_PORT_INPUT
    WINGS_PORT=${WINGS_PORT_INPUT:-8080}
    
    read -p "${CYAN}❯${NC} SFTP Port [2022]: " SFTP_PORT_INPUT
    SFTP_PORT=${SFTP_PORT_INPUT:-2022}
    
    # Validation
    echo -e "\n${YELLOW}Verifying configuration...${NC}"
    
    if [ -z "$PANEL_URL" ] || [ -z "$NODE_UUID" ] || [ -z "$TOKEN_ID" ] || [ -z "$TOKEN" ]; then
        error "All fields are required! Please run again."
    fi
    
    # Show summary
    echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Configuration Summary:${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "  Panel URL:  ${PANEL_URL}"
    echo -e "  Node UUID:  ${NODE_UUID}"
    echo -e "  Token ID:   ${TOKEN_ID}"
    echo -e "  API Port:   ${WINGS_PORT}"
    echo -e "  SFTP Port:  ${SFTP_PORT}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    read -p "Continue with this configuration? (y/n): " confirm_config
    if [ "$confirm_config" != "y" ] && [ "$confirm_config" != "Y" ]; then
        echo -e "\n${YELLOW}Configuration cancelled. Run again to re-enter.${NC}\n"
        exit 0
    fi
    
    # Configuration process
    echo -e "\n${CYAN}Configuring Wings...${NC}"
    
    # Create directories
    mkdir -p ${WINGS_DIR}
    mkdir -p /var/log/pterodactyl
    mkdir -p /var/lib/pterodactyl/volumes
    
    # Generate config
    cat > ${WINGS_DIR}/config.yml << EOF
debug: false
uuid: ${NODE_UUID}
token_id: ${TOKEN_ID}
token: ${TOKEN}
api:
  host: 0.0.0.0
  port: ${WINGS_PORT}
  ssl:
    enabled: false
    cert: /etc/letsencrypt/live/yourdomain.com/fullchain.pem
    key: /etc/letsencrypt/live/yourdomain.com/privkey.pem
system:
  data: /var/lib/pterodactyl/volumes
  sftp:
    bind_port: ${SFTP_PORT}
allowed_mounts: []
remote: ${PANEL_URL}
internal:
  dns:
    - 1.1.1.1
    - 1.0.0.1
  network:
    ispn_interface: eth0
    interfaces:
      - veth
      - v4
      - nat
      - host
docker:
  network:
    interface: 172.18.0.1
    dns:
      - 1.1.1.1
      - 1.0.0.1
    name: pterodactyl_nw
    ispn: false
    driver: bridge
    network_mode: bridge
    network: pterodactyl_nw
    ispn_network: pterodactyl_ispn
    ispn_driver: bridge
    auto_detect_interface: true
    bind:
      - 172.18.0.1/16
EOF
    
    success "Configuration saved to ${WINGS_DIR}/config.yml"
    
    # Set permissions
    chmod 600 ${WINGS_DIR}/config.yml
    chmod 755 /var/log/pterodactyl
    chmod 644 /var/log/pterodactyl/wings.log 2>/dev/null || touch /var/log/pterodactyl/wings.log && chmod 644 /var/log/pterodactyl/wings.log
    
    # Success message
    echo -e "\n${GREEN}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}  ${GREEN}✅ WINGS CONFIGURED SUCCESSFULLY!${NC}          ${GREEN}║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
    
    # Start Wings
    echo -e "${CYAN}Starting Wings...${NC}"
    read -p "Do you want to start Wings now? (y/n): " start_wings
    
    if [ "$start_wings" = "y" ] || [ "$start_wings" = "Y" ] || [ -z "$start_wings" ]; then
        echo -e "\n${CYAN}Starting Wings Daemon...${NC}"
        
        # Check if running
        if pgrep -x "wings" > /dev/null; then
            info "Wings already running, stopping..."
            pkill wings
            sleep 2
        fi
        
        # Start
        cd /usr/local/bin
        nohup wings > /var/log/pterodactyl/wings.log 2>&1 &
        WINGS_PID=$!
        echo $WINGS_PID > /var/run/wings.pid
        
        sleep 3
        
        # Verify
        if pgrep -x "wings" > /dev/null; then
            success "Wings started (PID: ${WINGS_PID})"
            
            echo -e "\n${GREEN}╔═══════════════════════════════════════════════╗${NC}"
            echo -e "${GREEN}║${NC}  ${GREEN}🎉 WINGS IS NOW RUNNING!${NC}                  ${GREEN}║${NC}"
            echo -e "${GREEN}╚═══════════════════════════════════════════════╝${NC}"
            echo ""
            echo -e "${MAGENTA}Next Steps:${NC}"
            echo "  1. Go to Panel: ${PANEL_URL}"
            echo "  2. Navigate: Admin → Nodes"
            echo "  3. Check for Connected (green dot)"
            echo "  4. Start creating game servers!"
            echo ""
            echo -e "${MAGENTA}Useful Commands:${NC}"
            echo "  View logs:    tail -f /var/log/pterodactyl/wings.log"
            echo "  Stop Wings:   pkill wings"
            echo "  Check status: ps aux | grep wings"
        else
            warn "Wings may not have started"
            echo -e "\n${YELLOW}Check logs: tail -f /var/log/pterodactyl/wings.log${NC}\n"
        fi
    else
        info "Start manually: wings --config /etc/pterodactyl/config.yml"
    fi
}

onecommand_deploy_wings() {
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}⚡ Auto-Deploy Wings (One Command)${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    info "Get token from Panel: Admin → Nodes → Click Node → Copy Token"
    echo -e "${YELLOW}💡 This will configure Wings with a single command!${NC}\n"
    
    # Get panel URL
    read -p "${CYAN}❯${NC} Panel URL (e.g., https://panel.example.com): " PANEL_URL
    echo ""
    
    # Get token
    read -p "${CYAN}❯${NC} Node Token (ptla_xxx): " NODE_TOKEN
    echo ""
    
    # Get node ID
    read -p "${CYAN}❯${NC} Node ID (number): " NODE_ID
    echo ""
    
    # Validate
    if [ -z "$PANEL_URL" ] || [ -z "$NODE_TOKEN" ] || [ -z "$NODE_ID" ]; then
        error "All fields are required!"
    fi
    
    # Show summary
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Deployment Summary:${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo "  Panel URL: ${PANEL_URL}"
    echo "  Token:     ${NODE_TOKEN:0:20}..."
    echo "  Node ID:   ${NODE_ID}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    read -p "Deploy Wings with this configuration? (y/n): " confirm_deploy
    if [ "$confirm_deploy" != "y" ] && [ "$confirm_deploy" != "Y" ]; then
        echo -e "\n${YELLOW}Deployment cancelled.${NC}\n"
        return
    fi
    
    # Install Wings if not exists
    if ! command -v wings &> /dev/null; then
        echo -e "\n${YELLOW}Installing Wings...${NC}"
        mkdir -p /usr/local/bin
        curl -L -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/download/v1.11.8/wings_linux_amd64" &>/dev/null
        chmod +x /usr/local/bin/wings
        success "Wings installed"
    fi
    
    # Create directories
    mkdir -p /etc/pterodactyl
    mkdir -p /var/log/pterodactyl
    mkdir -p /var/lib/pterodactyl/volumes
    
    # Run wings configure command
    echo -e "\n${CYAN}Deploying Wings...${NC}"
    echo -e "${YELLOW}Command: wings configure --panel-url ${PANEL_URL} --token ${NODE_TOKEN:0:15}... --node ${NODE_ID}${NC}\n"
    
    cd /etc/pterodactyl
    wings configure --panel-url "${PANEL_URL}" --token "${NODE_TOKEN}" --node "${NODE_ID}"
    
    if [ $? -eq 0 ]; then
        success "Wings configured successfully!"
        
        echo -e "\n${GREEN}╔═══════════════════════════════════════════════╗${NC}"
        echo -e "${GREEN}║${NC}  ${GREEN}✅ WINGS DEPLOYED SUCCESSFULLY!${NC}              ${GREEN}║${NC}"
        echo -e "${GREEN}╚═══════════════════════════════════════════════╝${NC}"
        echo ""
        
        # Start Wings
        read -p "Start Wings now? (y/n): " start_now
        if [ "$start_now" = "y" ] || [ "$start_now" = "Y" ]; then
            echo -e "\n${CYAN}Starting Wings...${NC}"
            
            # Stop if running
            if pgrep -x "wings" > /dev/null; then
                pkill wings
                sleep 2
            fi
            
            # Start
            nohup wings > /var/log/pterodactyl/wings.log 2>&1 &
            WINGS_PID=$!
            echo $WINGS_PID > /var/run/wings.pid
            
            sleep 3
            
            if pgrep -x "wings" > /dev/null; then
                success "Wings started (PID: ${WINGS_PID})"
                echo -e "\n${GREEN}🎉 Wings is now running and connected to Panel!${NC}"
                echo ""
                echo -e "${MAGENTA}Next Steps:${NC}"
                echo "  1. Go to Panel: ${PANEL_URL}"
                echo "  2. Navigate: Admin → Nodes"
                echo "  3. Check for Connected (green dot)"
                echo "  4. Start creating game servers!"
            else
                warn "Wings may not have started"
                echo -e "\n${YELLOW}Check logs: tail -f /var/log/pterodactyl/wings.log${NC}"
            fi
        else
            info "Start manually with: wings"
        fi
    else
        error "Failed to configure Wings. Check token and node ID!"
    fi
}

# Manual Configure Wings
manual_configure_wings() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}📋${NC} Manual Configuration..."
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    echo -e "${GREEN}Easy Steps:${NC}"
    echo "  1. Login to Pterodactyl Panel"
    echo "  2. Go to Admin → Nodes"
    echo "  3. Click on your node"
    echo "  4. Go to Configuration tab"
    echo "  5. Click 'Copy' button"
    echo ""
    
    read -p "${CYAN}❯${NC} Ready to paste? Press Enter to continue...${NC}"
    
    # Create directories
    mkdir -p ${WINGS_DIR}
    mkdir -p /var/log/pterodactyl
    mkdir -p /var/lib/pterodactyl/volumes
    
    echo -e "\n${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Paste config.yml below (Ctrl+D when done):${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo "---START PASTING (press Ctrl+D when done)---"
    
    # Read input until Ctrl+D
    cat > ${WINGS_DIR}/config.yml
    
    # Verify config
    if [ -f "${WINGS_DIR}/config.yml" ] && [ -s "${WINGS_DIR}/config.yml" ]; then
        success "Configuration saved!"
        chmod 600 ${WINGS_DIR}/config.yml
        
        echo -e "\n${GREEN}╔═══════════════════════════════════════════════╗${NC}"
        echo -e "${GREEN}║   ✅ CONFIGURATION SAVED!                     ║${NC}"
        echo -e "${GREEN}╚═══════════════════════════════════════════════╝${NC}\n"
        
        read -p "${CYAN}❯${NC} Start Wings now? (y/n): ${WHITE}" start_wings
        echo -e "${NC}"
        
        if [ "$start_wings" = "y" ] || [ "$start_wings" = "Y" ] || [ -z "$start_wings" ]; then
            echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
            echo -e "${BLUE}▶️${NC} Starting Wings..."
            echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
            
            # Stop if running
            if pgrep -x "wings" > /dev/null; then
                pkill wings
                sleep 2
            fi
            
            # Create log file
            touch /var/log/pterodactyl/wings.log
            chmod 644 /var/log/pterodactyl/wings.log
            
            # Start Wings
            cd /usr/local/bin
            nohup wings > /var/log/pterodactyl/wings.log 2>&1 &
            WINGS_PID=$!
            echo $WINGS_PID > /var/run/wings.pid
            
            sleep 3
            
            if pgrep -x "wings" > /dev/null; then
                success "Wings started (PID: ${WINGS_PID})"
                echo -e "\n${GREEN}✅ Wings is running!${NC}"
                echo -e "${CYAN}📋 Logs: ${WHITE}tail -f /var/log/pterodactyl/wings.log${NC}\n"
            else
                warn "Wings may not have started"
                echo -e "\n${YELLOW}Check logs: ${WHITE}tail -f /var/log/pterodactyl/wings.log${NC}\n"
            fi
        fi
    else
        error "Configuration file is empty!"
    fi
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

    # Create log directory
    mkdir -p /var/log/pterodactyl
    touch /var/log/pterodactyl/wings.log
    chmod 755 /var/log/pterodactyl
    chmod 644 /var/log/pterodactyl/wings.log

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
    echo "  configure      - Auto-configure Wings (enter UUID, Token, etc.)"
    echo "  themes         - Install Themes (Blueprint + Nebula + Hyper-V)"
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
    echo "  $0 configure     # Auto-configure Wings with UUID/Token"
    echo "  $0 themes        # Install themes menu"
    echo "  $0 quick"
    echo ""
    echo -e "${CYAN}🌐 GitHub:${NC} ${GITHUB_REPO}"
    echo -e "${BLUE}Made by SATYAM BHAIi${NC}"
    echo -e "${BLUE}Version: ${SCRIPT_VERSION}${NC}"
}

# Main menu
main_menu() {
    show_logo

    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}  Select an Option:${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "  ${GREEN}1${NC}) Install Pterodactyl Panel"
    echo -e "  ${GREEN}2${NC}) Install Wings Daemon"
    echo -e "  ${GREEN}3${NC}) Quick Setup (Panel + Wings)"
    echo -e "  ${GREEN}4${NC}) Auto-Configure Wings ${YELLOW}⭐${NC} (Recommended)"
    echo -e "  ${GREEN}5${NC}) Install Themes ${MAGENTA}🎨${NC} (Blueprint + Nebula + Hyper-V)"
    echo -e "  ${GREEN}6${NC}) Uninstall Pterodactyl"
    echo -e "  ${GREEN}0${NC}) Exit"
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    read -p "${CYAN}❯${NC} Enter your choice [0-6]: " choice
    echo ""

    case $choice in
        0|1|2|3|4|5|6)
            ;;
        *)
            echo -e "${RED}❌ Invalid option. Please enter 0-6.${NC}\n"
            main_menu
            ;;
    esac

    case $choice in
        1) install_panel ;;
        2) install_wings_only ;;
        3) quick_setup ;;
        4) auto_configure_wings ;;
        5) install_themes_menu ;;
        6) uninstall ;;
        0) echo -e "${GREEN}👋 Goodbye!${NC}\n"; exit 0 ;;
    esac
}

# ─────────────────────────────────────────────────────────────────────
# THEME INSTALLER (Blueprint + Nebula + Hyper-V)
# ─────────────────────────────────────────────────────────────────────

install_themes_menu() {
    show_logo
    
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${MAGENTA}🎨 Theme & Extensions Installer${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "  ${GREEN}1${NC}) Install Blueprint Framework (Required)"
    echo -e "  ${GREEN}2${NC}) Install SATYAM's Extensions ${YELLOW}⭐${NC}"
    echo -e "  ${GREEN}3${NC}) Install Nebula Theme"
    echo -e "  ${GREEN}4${NC}) Install Hyper-V Theme"
    echo -e "  ${GREEN}5${NC}) Install All (Blueprint + Extensions + Themes)"
    echo -e "  ${GREEN}0${NC}) Back to Main Menu"
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    read -p "${CYAN}❯${NC} Enter your choice [0-5]: " theme_choice
    echo ""
    
    case $theme_choice in
        1) install_blueprint ;;
        2) 
            # Install only local blueprints
            read -p "${CYAN}❯${NC} Enter Pterodactyl directory [/var/www/pterodactyl]: " PANEL_DIR_INPUT
            PANEL_DIR_INPUT=${PANEL_DIR_INPUT:-/var/www/pterodactyl}
            echo ""
            if [[ ! -d "$PANEL_DIR_INPUT" ]]; then
                error "Directory $PANEL_DIR_INPUT does not exist!"
            fi
            install_local_blueprints "$PANEL_DIR_INPUT"
            ;;
        3) install_nebula_theme ;;
        4) install_hyperv_theme ;;
        5) install_all_themes ;;
        0) main_menu ;;
        *) echo -e "${RED}❌ Invalid option.${NC}\n"; install_themes_menu ;;
    esac
}

install_blueprint() {
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}📦 Installing Blueprint Framework${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    # Get panel directory
    read -p "${CYAN}❯${NC} Enter Pterodactyl directory [/var/www/pterodactyl]: " PANEL_DIR_INPUT
    PANEL_DIR_INPUT=${PANEL_DIR_INPUT:-/var/www/pterodactyl}
    echo ""
    
    if [[ ! -d "$PANEL_DIR_INPUT" ]]; then
        error "Directory $PANEL_DIR_INPUT does not exist!"
    fi
    
    info "Panel Directory: $PANEL_DIR_INPUT"
    echo ""
    
    # Install dependencies
    echo -e "${YELLOW}Installing dependencies...${NC}"
    apt-get install -y curl wget unzip zip &>/dev/null
    
    # Install Node.js
    echo -e "${YELLOW}Installing Node.js...${NC}"
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - &>/dev/null
    apt-get install -y nodejs &>/dev/null
    npm install -g yarn &>/dev/null
    
    cd "$PANEL_DIR_INPUT" || exit
    
    # Download Blueprint
    echo -e "${YELLOW}Downloading Blueprint...${NC}"
    wget -q "https://github.com/BlueprintFramework/framework/releases/latest/download/release.zip" -O "$PANEL_DIR_INPUT/release.zip"
    unzip -o release.zip &>/dev/null
    rm -f release.zip
    
    # Create .blueprintrc
    echo -e "${YELLOW}Configuring Blueprint...${NC}"
    cat > "$PANEL_DIR_INPUT/.blueprintrc" << 'EOF'
WEBUSER="www-data";
OWNERSHIP="www-data:www-data";
USERSHELL="/bin/bash";
EOF
    
    # Set permissions
    chmod +x "$PANEL_DIR_INPUT/blueprint.sh"
    chown -R www-data:www-data "$PANEL_DIR_INPUT"
    
    # Install Node dependencies
    echo -e "${YELLOW}Installing Node dependencies...${NC}"
    cd "$PANEL_DIR_INPUT"
    yarn install &>/dev/null
    
    # Run Blueprint
    echo -e "${YELLOW}Running Blueprint...${NC}"
    bash "$PANEL_DIR_INPUT/blueprint.sh" &>/dev/null
    
    # Clear cache
    cd "$PANEL_DIR_INPUT"
    php artisan config:clear &>/dev/null
    php artisan cache:clear &>/dev/null
    php artisan optimize &>/dev/null
    
    success "Blueprint Framework installed successfully!"
    echo ""
    
    # Install local blueprints
    echo -e "\n${YELLOW}Installing SATYAM BHAIi's Custom Blueprints...${NC}"
    install_local_blueprints "$PANEL_DIR_INPUT"
    
    echo ""
    echo -e "${GREEN}Next: Install themes (Nebula or Hyper-V)${NC}"
    echo ""
    
    read -p "Install themes now? (y/n): " install_now
    if [[ "$install_now" =~ ^[Yy]$ ]]; then
        install_themes_menu
    fi
}

install_local_blueprints() {
    local TARGET_DIR="${1:-/var/www/pterodactyl}"
    
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${MAGENTA}📦 Installing Local Blueprints${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    # Local blueprints path (Windows path for upload)
    LOCAL_BLUEPRINTS_DIR="C:/Users/sgsat/OneDrive/Desktop/google colab/themes"
    
    # Available blueprints
    BLUEPRINTS=(
        "huxregister.blueprint"
        "mcplugins.blueprint"
        "sagaminecraftplayermanager.blueprint"
        "versionchanger.blueprint"
    )
    
    echo -e "${YELLOW}Installing SATYAM BHAIi's Custom Extensions:${NC}"
    echo "  • HuxRegister (User Registration System)"
    echo "  • MCPlugins (Minecraft Plugins Manager)"
    echo "  • SagaMinecraftPlayerManager (Player Management)"
    echo "  • VersionChanger (Version Switcher)"
    echo ""
    
    # Copy blueprints to panel
    echo -e "${YELLOW}Copying blueprints to panel...${NC}"
    
    # Create blueprints directory if not exists
    mkdir -p "$TARGET_DIR/blueprints"
    
    # Copy each blueprint (from Windows path via scp or manual upload)
    for blueprint in "${BLUEPRINTS[@]}"; do
        if [[ -f "$LOCAL_BLUEPRINTS_DIR/$blueprint" ]]; then
            # For local execution (if running on same machine)
            cp "$LOCAL_BLUEPRINTS_DIR/$blueprint" "$TARGET_DIR/blueprints/" 2>/dev/null || true
            echo -e "  ${GREEN}✓${NC} Copied $blueprint"
        else
            # If file not found, create placeholder
            echo -e "  ${YELLOW}!${NC} $blueprint (Manual upload required)"
        fi
    done
    
    # Set permissions
    chown -R www-data:www-data "$TARGET_DIR/blueprints"
    chmod 644 "$TARGET_DIR/blueprints"/*.blueprint 2>/dev/null || true
    
    # Run blueprint install command
    echo -e "\n${YELLOW}Installing blueprints via Blueprint CLI...${NC}"
    cd "$TARGET_DIR"
    
    # Install each blueprint
    for blueprint in "${BLUEPRINTS[@]}"; do
        if [[ -f "$TARGET_DIR/blueprints/$blueprint" ]]; then
            echo -e "  ${GREEN}✓${NC} Installing $blueprint..."
            bash blueprint.sh install "$blueprint" &>/dev/null || true
        fi
    done
    
    # Clear cache
    php artisan config:clear &>/dev/null
    php artisan cache:clear &>/dev/null
    php artisan optimize &>/dev/null
    
    success "All local blueprints installed!"
    echo ""
    echo -e "${GREEN}Extensions activated in your panel!${NC}"
}

install_nebula_theme() {
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${MAGENTA}🎨 Installing Nebula Theme${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    # Check if Blueprint is installed
    if [[ ! -f "/var/www/pterodactyl/blueprint.sh" ]]; then
        warn "Blueprint not found! Installing first..."
        install_blueprint
    fi
    
    read -p "${CYAN}❯${NC} Enter Pterodactyl directory [/var/www/pterodactyl]: " PANEL_DIR_INPUT
    PANEL_DIR_INPUT=${PANEL_DIR_INPUT:-/var/www/pterodactyl}
    echo ""
    
    cd "$PANEL_DIR_INPUT" || exit
    
    # Download Nebula
    echo -e "${YELLOW}Downloading Nebula Theme...${NC}"
    NEBULA_URL="https://github.com/BlueprintFramework/nebula-theme/releases/latest/download/release.zip"
    wget -q "$NEBULA_URL" -O nebula.zip
    unzip -o nebula.zip &>/dev/null
    rm -f nebula.zip
    
    # Set permissions
    chown -R www-data:www-data "$PANEL_DIR_INPUT"
    chmod -R 755 "$PANEL_DIR_INPUT/storage" "$PANEL_DIR_INPUT/bootstrap/cache"
    
    # Clear cache
    php artisan config:clear &>/dev/null
    php artisan cache:clear &>/dev/null
    php artisan view:clear &>/dev/null
    php artisan optimize &>/dev/null
    
    success "Nebula Theme installed successfully!"
    echo ""
    echo -e "${GREEN}Theme activated! Refresh your panel to see changes.${NC}"
}

install_hyperv_theme() {
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${MAGENTA}🎨 Installing Hyper-V Theme${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    # Check if Blueprint is installed
    if [[ ! -f "/var/www/pterodactyl/blueprint.sh" ]]; then
        warn "Blueprint not found! Installing first..."
        install_blueprint
    fi
    
    read -p "${CYAN}❯${NC} Enter Pterodactyl directory [/var/www/pterodactyl]: " PANEL_DIR_INPUT
    PANEL_DIR_INPUT=${PANEL_DIR_INPUT:-/var/www/pterodactyl}
    echo ""
    
    cd "$PANEL_DIR_INPUT" || exit
    
    # Download Hyper-V
    echo -e "${YELLOW}Downloading Hyper-V Theme...${NC}"
    HYPERV_URL="https://r2.rolexdev.tech/hyperv1/Hyperv1.tar"
    wget -q "$HYPERV_URL" -O Hyperv1.tar
    
    # Extract
    echo -e "${YELLOW}Extracting Hyper-V...${NC}"
    tar -xf Hyperv1.tar --overwrite
    rm -f Hyperv1.tar
    
    # Set permissions
    echo -e "${YELLOW}Setting permissions...${NC}"
    chown -R www-data:www-data "$PANEL_DIR_INPUT"
    chmod -R 755 "$PANEL_DIR_INPUT/storage" "$PANEL_DIR_INPUT/bootstrap/cache"
    
    # Make scripts executable
    chmod +x "$PANEL_DIR_INPUT/hyper_fetch.sh" 2>/dev/null || true
    chmod +x "$PANEL_DIR_INPUT/hyper_auto_update.sh" 2>/dev/null || true
    
    # Clear cache
    php artisan config:clear &>/dev/null
    php artisan cache:clear &>/dev/null
    php artisan view:clear &>/dev/null
    php artisan optimize &>/dev/null
    
    success "Hyper-V Theme installed successfully!"
    echo ""
    echo -e "${GREEN}Theme activated! Refresh your panel to see changes.${NC}"
}

install_all_themes() {
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${MAGENTA}🎨 Installing Complete Package${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${YELLOW}This will install:${NC}"
    echo "  ✓ Blueprint Framework"
    echo "  ✓ SATYAM's Custom Extensions (4 blueprints)"
    echo "  ✓ Nebula Theme"
    echo "  ✓ Hyper-V Theme"
    echo ""
    
    read -p "Continue? (y/n): " confirm_all
    if [[ ! "$confirm_all" =~ ^[Yy]$ ]]; then
        echo -e "\n${YELLOW}Installation cancelled.${NC}"
        return
    fi
    
    # Install Blueprint first
    install_blueprint
    
    # Install Nebula
    echo -e "\n${YELLOW}Installing Nebula Theme...${NC}"
    install_nebula_theme
    
    # Install Hyper-V
    echo -e "\n${YELLOW}Installing Hyper-V Theme...${NC}"
    install_hyperv_theme
    
    echo -e "\n${GREEN}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}  ${GREEN}✅ COMPLETE PACKAGE INSTALLED!${NC}              ${GREEN}║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${MAGENTA}Installed:${NC}"
    echo "  ✓ Blueprint Framework"
    echo "  ✓ HuxRegister Extension"
    echo "  ✓ MCPlugins Extension"
    echo "  ✓ SagaMinecraftPlayerManager Extension"
    echo "  ✓ VersionChanger Extension"
    echo "  ✓ Nebula Theme"
    echo "  ✓ Hyper-V Theme"
    echo ""
    echo -e "${YELLOW}Refresh your panel to see all changes!${NC}"
    echo -e "${MAGENTA}Made by SATYAM BHAIi${NC}"
}

# ─────────────────────────────────────────────────────────────────────
# END THEME INSTALLER
# ─────────────────────────────────────────────────────────────────────

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
    configure)
        show_logo
        echo -e "${YELLOW}Starting Wings Auto-Configuration...${NC}\n"
        check_root
        install_wings
        auto_configure_wings
        ;;
    themes)
        install_themes_menu
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
