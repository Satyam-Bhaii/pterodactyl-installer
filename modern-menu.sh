#!/bin/bash

# ─────────────────────────────────────────────────────────────────────
# SATYAM BHAIi MODERN GRID MENU - v4.0
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

# Script URLs
MAIN_INSTALLER="https://raw.githubusercontent.com/Satyam-Bhaii/pterodactyl-installer/main/pterodactyl-installer.sh"

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

check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}✗ This script must be run as root${NC}"
        echo -e "${YELLOW}Run with: sudo bash modern-menu.sh${NC}"
        sleep 3
        exit 1
    fi
}

check_internet() {
    if ! ping -c 1 8.8.8.8 &>/dev/null; then
        echo -e "${RED}✗ No internet connection!${NC}"
        sleep 3
        exit 1
    fi
}

run_installer() {
    local option="$1"
    local description="$2"
    
    echo -e "  ${CYAN}➜ Installing $description...${NC}"
    echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    # Check if curl is available
    if ! command -v curl &> /dev/null; then
        echo -e "${RED}✗ curl not found! Installing...${NC}"
        apt-get update -qq && apt-get install -y -qq curl
    fi
    
    # Download and run installer
    if bash <(curl -sL "$MAIN_INSTALLER") "$option"; then
        echo -e "\n${GREEN}✓ $description completed!${NC}"
    else
        echo -e "\n${RED}✗ $description failed!${NC}"
        echo -e "${YELLOW}Try running manually: bash <(curl -sL $MAIN_INSTALLER) $option${NC}"
    fi
    
    pause
}

# Main Grid Menu
panel_menu() {
    # Check root and internet
    check_root
    check_internet
    
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
            1)  run_installer "panel" "Pterodactyl Panel" ;;
            2)  run_installer "themes" "SATYAM Theme" ;;
            3)  run_installer "themes" "Nebula Theme" ;;
            4)  run_installer "themes" "Hyper-V Theme" ;;
            5)  run_installer "themes" "Extensions" ;;
            6)  run_installer "themes" "All Extensions" ;;
            7)  run_installer "wings" "Wings Daemon" ;;
            8)  run_installer "configure" "Wings Auto-Configuration" ;;
            9)  run_installer "quick" "Quick Setup (Panel + Wings)" ;;
            10) run_installer "uninstall" "Panel Uninstall" ;;
            11) 
                echo -e "  ${CYAN}➜ Showing Credentials...${NC}"
                echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
                echo ""
                if [[ -f /root/pterodactyl_credentials.txt ]]; then
                    cat /root/pterodactyl_credentials.txt
                else
                    echo -e "${RED}✗ No credentials found!${NC}"
                    echo -e "${YELLOW}Panel may not be installed yet.${NC}"
                fi
                pause
                ;;
            0)  echo -e "\n  ${RED}👋 Shutting down. Goodbye!${NC}"
                exit 0 ;;
            *)  echo -e "  ${RED}⚠ Invalid Selection${NC}"
                sleep 1 ;;
        esac
    done
}

# Run the menu
panel_menu
