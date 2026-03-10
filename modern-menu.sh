#!/bin/bash

# ─────────────────────────────────────────────────────────────────────
# SATYAM BHAIi MODERN GRID MENU
# ─────────────────────────────────────────────────────────────────────

# SEMA UI COLORS
CYAN='\033[38;5;51m'
PURPLE='\033[38;5;141m'
GRAY='\033[38;5;242m'
WHITE='\033[38;5;255m'
GREEN='\033[38;5;82m'
RED='\033[38;5;196m'
GOLD='\033[38;5;220m'
PINK='\033[38;5;213m'
BLUE='\033[38;5;27m'
NC='\033[0m'

# Helper Functions
pause() {
    echo -e ""
    echo -ne "  ${GRAY}Press any key to continue...${NC}"
    read -n 1 -s -r
    echo ""
}

get_metrics() {
    if command -v uptime &> /dev/null; then
        UPT=$(uptime -p 2>/dev/null | sed 's/up //' || echo "N/A")
        LOAD=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d, -f1 | xargs 2>/dev/null || echo "N/A")
    else
        UPT="N/A"
        LOAD="N/A"
    fi
}

show_header() {
    get_metrics
    clear
    echo -e "${PURPLE}┌──────────────────────────────────────────────────────────┐${NC}"
    echo -e "${PURPLE}│${NC}  ${CYAN}🚀 SATYAM BHAIi PANEL MANAGER${NC} ${GRAY}v4.0${NC}    ${GRAY}$(date +"%H:%M")${NC}  ${PURPLE}│${NC}"
    echo -e "${PURPLE}└──────────────────────────────────────────────────────────┘${NC}"
    echo -e "  ${CYAN}SYSTEM STATUS${NC}"
    echo -e "  ${GRAY}├─ Uptime :${NC} ${WHITE}$UPT${NC}"
    echo -e "  ${GRAY}└─ Load   :${NC} ${WHITE}$LOAD${NC}"
    echo -e "${GRAY}────────────────────────────────────────────────────────────${NC}"
}

# Main Grid Menu
panel_menu() {
    while true; do
        show_header
        
        echo -e "  ${GOLD}📦 AVAILABLE DEPLOYMENTS${NC}"
        echo -e "  ${GRAY}┌──────────────────────────┬──────────────────────────┐${NC}"
        echo -e "  ${GRAY}│${NC} ${PURPLE}[1]${NC} Pterodactyl Panel    ${GRAY}│${NC} ${PURPLE}[7]${NC}  Wings Daemon          ${GRAY}│${NC}"
        echo -e "  ${GRAY}│${NC} ${PURPLE}[2]${NC} SATYAM Theme 🔥      ${GRAY}│${NC} ${PURPLE}[8]${NC}  Auto-Configure Wings  ${GRAY}│${NC}"
        echo -e "  ${GRAY}│${NC} ${PURPLE}[3]${NC} Nebula Theme         ${GRAY}│${NC} ${PURPLE}[9]${NC}  Quick Setup           ${GRAY}│${NC}"
        echo -e "  ${GRAY}│${NC} ${PURPLE}[4]${NC} Hyper-V Theme        ${GRAY}│${NC} ${PURPLE}[10]${NC} Uninstall Panel        ${GRAY}│${NC}"
        echo -e "  ${GRAY}│${NC} ${PURPLE}[5]${NC} Extensions (BP)      ${GRAY}│${NC} ${PURPLE}[11]${NC} View Credentials       ${GRAY}│${NC}"
        echo -e "  ${GRAY}│${NC} ${PURPLE}[6]${NC} All Extensions ⭐     ${GRAY}│${NC} ${RED}[0]${NC} Exit                   ${GRAY}│${NC}"
        echo -e "  ${GRAY}└──────────────────────────┴──────────────────────────┘${NC}"
        echo ""
        echo -ne "  ${CYAN}λ${NC} ${WHITE}Select Module [0-11]:${NC} "
        read p

        case $p in
            1)  echo -e "  ${CYAN}➜ Installing Pterodactyl Panel...${NC}"
                bash <(curl -s https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh) panel
                pause ;;
            2)  echo -e "  ${CYAN}➜ Installing SATYAM Theme...${NC}"
                bash <(curl -s https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh) themes
                pause ;;
            3)  echo -e "  ${CYAN}➜ Installing Nebula Theme...${NC}"
                bash <(curl -s https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh) themes
                pause ;;
            4)  echo -e "  ${CYAN}➜ Installing Hyper-V Theme...${NC}"
                bash <(curl -s https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh) themes
                pause ;;
            5)  echo -e "  ${CYAN}➜ Installing Extensions...${NC}"
                bash <(curl -s https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh) themes
                pause ;;
            6)  echo -e "  ${CYAN}➜ Installing All Extensions...${NC}"
                bash <(curl -s https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh) themes
                pause ;;
            7)  echo -e "  ${CYAN}➜ Installing Wings Daemon...${NC}"
                bash <(curl -s https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh) wings
                pause ;;
            8)  echo -e "  ${CYAN}➜ Auto-Configuring Wings...${NC}"
                bash <(curl -s https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh) configure
                pause ;;
            9)  echo -e "  ${CYAN}➜ Quick Setup (Panel + Wings)...${NC}"
                bash <(curl -s https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh) quick
                pause ;;
            10) echo -e "  ${CYAN}➜ Uninstalling Pterodactyl...${NC}"
                bash <(curl -s https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh) uninstall
                pause ;;
            11) echo -e "  ${CYAN}➜ Showing Credentials...${NC}"
                cat /root/pterodactyl_credentials.txt 2>/dev/null || echo -e "  ${RED}No credentials found!${NC}"
                pause ;;
            0)  echo -e "\n  ${RED}👋 Shutting down. Goodbye!${NC}"
                exit 0 ;;
            *)  echo -e "  ${RED}⚠ Invalid Selection${NC}"
                sleep 1 ;;
        esac
    done
}

# Run the menu
panel_menu
