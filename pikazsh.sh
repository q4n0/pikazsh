#!/bin/bash

# Welcome Banner
echo -e "\e[31m⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠶⠤⢤⣀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡤⠶⠾⠷⠶⠶⣤⣈⣷
⠀⠀⠀⠀⠀⠀⣠⠾⢀⣤⣴⣶⣶⣶⣶⣦⣤⡉⠛⢦⡀
⠀⠀⠀⠀⢀⡾⢡⠞⠻⣿⣿⡿⢻⣿⣿⣿⣿⡿⠃⠀⠻⣆
⠀⠀⠀⠀⣾⢡⣿⠀⠀⣿⡟⠀⠀⣿⣿⣿⣿⣇⠀⠀⡀⢻⣆⣤⠶⠒⠒⠶⣤⡀
⠀⠀⠀⠀⣿⣾⣿⣄⣴⣿⣷⡀⣠⣿⣿⣿⣿⣿⣿⣿⣷⠘⣿⠧⣤⠻⠽⠂⢈⣿
⠀⠀⣠⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⢸⣿⡛⠛⣴⣲⠄⢸⡇
⢰⡟⠁⠀⠈⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢡⡿⠙⢿⣦⣤⣤⣤⠾⠃
⢸⡇⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢛⣵⠟⠀⠀⣼⠃⠀⠀⠀⠀
⠈⠻⣆⠀⠀⠀⠀⠀⣻⠾⢿⣿⣛⣛⣻⣯⣵⡾⠛⠁⠀⠀⢀⣿⠀⠀⠀⠀⠀
⠀⠀⠙⠷⣄⣀⣀⣠⡿⠀⠀⠀⠀⠀⠀⠀⠀⢷⡀⠀⠀⢀⣾⠃⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠈⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠳⠾⠛⠁\e[0m"
echo "Advanced ZSH Setup by b0urn3 (Chris). Enjoy!"

# Set default values
DRY_RUN=false
VERBOSE=false
LOG_FILE="/tmp/zsh_setup_$(date +%Y%m%d_%H%M%S).log"

# Function to display usage information
usage() {
    echo "Usage: $0 [-d|--dry-run] [-v|--verbose] [-h|--help]"
    echo "  -d, --dry-run    Run script without making any changes"
    echo "  -v, --verbose    Enable verbose output"
    echo "  -h, --help       Display this help message"
}

# Parse command-line options
while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--dry-run)
            DRY_RUN=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Function for logging
log() {
    local level=$1
    shift
    local message="$@"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE"
    if [[ "$VERBOSE" == true || "$level" == "ERROR" ]]; then
        echo "[$level] $message"
    fi
}

# Function to check and install package manager
setup_package_manager() {
    if command -v apt-get &> /dev/null; then
        PM="apt-get"
        PM_INSTALL="apt-get install -y"
    elif command -v yum &> /dev/null; then
        PM="yum"
        PM_INSTALL="yum install -y"
    elif command -v pacman &> /dev/null; then
        PM="pacman"
        PM_INSTALL="pacman -S --noconfirm"
    else
        log "ERROR" "No supported package manager found. Exiting."
        exit 1
    fi
    log "INFO" "Using package manager: $PM"
}

# Function to install a package
install_package() {
    local package=$1
    if [[ "$DRY_RUN" == true ]]; then
        log "DRY-RUN" "Would install package: $package"
    else
        log "INFO" "Installing package: $package"
        if $PM_INSTALL $package; then
            log "INFO" "Package $package installed successfully"
        else
            log "ERROR" "Failed to install package: $package"
            exit 1
        fi
    fi
}

# Function to backup existing configurations
backup_configs() {
    local backup_dir="$HOME/.zsh_setup_backup_$(date +%Y%m%d_%H%M%S)"
    if [[ "$DRY_RUN" == true ]]; then
        log "DRY-RUN" "Would create backup directory: $backup_dir"
        log "DRY-RUN" "Would backup existing .zshrc and .oh-my-zsh"
    else
        log "INFO" "Creating backup directory: $backup_dir"
        mkdir -p "$backup_dir"
        
        if [[ -f "$HOME/.zshrc" ]]; then
            log "INFO" "Backing up existing .zshrc"
            cp "$HOME/.zshrc" "$backup_dir/.zshrc.bak"
        fi
        
        if [[ -d "$HOME/.oh-my-zsh" ]]; then
            log "INFO" "Backing up existing .oh-my-zsh directory"
            cp -r "$HOME/.oh-my-zsh" "$backup_dir/.oh-my-zsh.bak"
        fi
    fi
}

# Function to install Zsh
install_zsh() {
    if [[ "$DRY_RUN" == true ]]; then
        log "DRY-RUN" "Would install Zsh"
    else
        log "INFO" "Installing Zsh"
        install_package "zsh"
    fi
}

# Function to change shell to Zsh
change_shell() {
    if [[ "$DRY_RUN" == true ]]; then
        log "DRY-RUN" "Would change shell to Zsh"
    else
        log "INFO" "Changing shell to Zsh"
        chsh -s $(which zsh)
        if [[ $? -eq 0 ]]; then
            log "INFO" "Shell changed to Zsh successfully"
        else
            log "ERROR" "Failed to change shell to Zsh"
            exit 1
        fi
    fi
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
    if [[ "$DRY_RUN" == true ]]; then
        log "DRY-RUN" "Would install Oh My Zsh"
    else
        log "INFO" "Installing Oh My Zsh"
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        if [[ $? -eq 0 ]]; then
            log "INFO" "Oh My Zsh installed successfully"
        else
            log "ERROR" "Failed to install Oh My Zsh"
            exit 1
        fi
    fi
}

# Function to install Zsh plugins
install_zsh_plugins() {
    local plugins=("zsh-syntax-highlighting" "zsh-autosuggestions")
    
    for plugin in "${plugins[@]}"; do
        if [[ "$DRY_RUN" == true ]]; then
            log "DRY-RUN" "Would install Zsh plugin: $plugin"
        else
            log "INFO" "Installing Zsh plugin: $plugin"
            git clone "https://github.com/zsh-users/$plugin.git" "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin"
            if [[ $? -eq 0 ]]; then
                log "INFO" "Zsh plugin $plugin installed successfully"
            else
                log "ERROR" "Failed to install Zsh plugin: $plugin"
                exit 1
            fi
        fi
    done
}

# Main execution
main() {
    log "INFO" "Starting Zsh setup script"
    
    setup_package_manager
    backup_configs
    
    if ! command -v zsh &> /dev/null; then
        install_zsh
    fi
    
    if [[ "$(basename "$SHELL")" != "zsh" ]]; then
        change_shell
    fi
    
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        install_oh_my_zsh
    fi
    
    install_zsh_plugins
    
    log "INFO" "Zsh setup completed successfully"
}

# Run the main function
if [[ "$DRY_RUN" == true ]]; then
    log "DRY-RUN" "Performing dry run"
fi

main

echo "Setup complete! Please restart your terminal or run 'source ~/.zshrc' to apply changes."
