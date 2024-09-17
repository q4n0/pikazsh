#!/bin/bash

GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
PURPLE='\033[1;35m'
RESET='\033[0m'

display_message() {
    local message="$1"
    echo -e "${PURPLE}[${CYAN}${message}${PURPLE}]${RESET}"
}

progress_bar() {
    local duration=$1
    local steps=30
    local count=0
    local process_name="$2"
    local msg
    local sleep_time=$((duration / steps))
    local remainder=$((duration % steps))

    printf "${YELLOW}["
    while [ $count -lt $steps ]; do
        sleep $sleep_time
        printf "▓"
        
        # Update the process message every 10 steps
        if (( count % 10 == 0 && count != 0 )); then
            msg="Executing ${process_name}"
            display_message "$msg"
        fi
        count=$((count + 1))
    done
    # Handle any remaining time
    if [ $remainder -ne 0 ]; then
        sleep $remainder
    fi
    printf "] ${GREEN}Done!${RESET}\n"
}

is_zsh_installed() {
    command -v zsh >/dev/null 2>&1
}

install_zsh() {
    if ! is_zsh_installed; then
        display_message "Injecting ZSH into system..."
        (sudo apt install zsh -y >/dev/null 2>&1) &
        wait
        progress_bar 5 "ZSH installation"
    else
        echo -e "${GREEN}ZSH is already installed.${RESET}"
    fi
}

switch_to_zsh() {
    if [[ "$SHELL" != "/bin/zsh" ]]; then
        display_message "Configuring ZSH as the default shell..."
        (chsh -s /bin/zsh "$USER" >/dev/null 2>&1) &
        wait
        progress_bar 5 "Shell configuration"
    else
        echo -e "${GREEN}ZSH is already the default shell.${RESET}"
    fi
}

clone_repo() {
    display_message "Cloning repository for system infiltration..."
    (git clone "$1" "$2" >/dev/null 2>&1) &
    wait
    progress_bar 5 "Repository cloning"
}

compile_and_rename() {
    display_message "Injecting C code into system directory..."
    (cd "$1" && gcc -o term termpika.c >/dev/null 2>&1) &
    wait
    progress_bar 5 "C code injection"
}

move_executable() {
    display_message "Deploying executable to /usr/bin..."
    (sudo mv "$1/term" "/usr/bin/term" >/dev/null 2>&1) &
    wait
    progress_bar 5 "Executable deployment"
}

replace_zshrc() {
    display_message "Overwriting .zshrc configuration..."
    [ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
    (cp "$1/.zshrc" "$HOME/.zshrc" >/dev/null 2>&1) &
    wait
    progress_bar 5 "Configuration overwrite"
}

cleanup() {
    display_message "Searching for 'terminalpika' folder for purge..."
    found_terminalpika=$(find "$HOME" -type d -name "terminalpika" 2>/dev/null)
    
    if [ -z "$found_terminalpika" ]; then
        echo -e "${RED}'terminalpika' folder not found.${RESET}"
    else
        echo -e "${GREEN}'terminalpika' folder found!${RESET}"
        display_message "Purge initiated for repository folder..."
        rm -rf "$found_terminalpika"
        echo -e "${GREEN}Purge complete.${RESET}"
    fi
}

self_destruct() {
    display_message "Initiating self-destruction sequence..."
    
    script_dir=$(dirname "$(readlink -f "$0")")

    if [ -d "$script_dir" ]; then
        display_message "Executing final purge of 'terminalpika' directory..."
        rm -rf "$script_dir"
        echo -e "${GREEN}Self-destruction complete.${RESET}"
    else
        echo -e "${RED}Error: Could not locate script directory for self-destruction.${RESET}"
    fi
}

repo_url="https://github.com/q4n0/terminalpika.git"
clone_dir="terminalpika"

install_zsh
switch_to_zsh
clone_repo "$repo_url" "$clone_dir"
compile_and_rename "$clone_dir"
move_executable "$clone_dir"
replace_zshrc "$clone_dir"

if [ -f ~/.zshrc ]; then
    display_message "Sourcing new .zshrc configuration..."
    source ~/.zshrc
    progress_bar 5 "Shell configuration"
else
    echo -e "${RED}.zshrc not found.${RESET}"
fi

cleanup
self_destruct

# Clear the terminal screen and display a summary message
clear
echo -e "${GREEN}TerminalPika setup complete! Here's what changed:${RESET}"
echo -e "${CYAN}- ZSH has been installed and set as the default shell.${RESET}"
echo -e "${CYAN}- C code has been injected and the executable deployed to /usr/bin/term.${RESET}"
echo -e "${CYAN}- Your .zshrc file has been replaced with a new configuration.${RESET}"
echo -e "${CYAN}- The 'terminalpika' repository folder has been purged and the script directory self-destructed.${RESET}"
echo -e "${GREEN}Enjoy your customized terminal!${RESET}"
