#!/bin/bash

# Define colors
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
RESET='\033[0m'

# Function to show a progress bar
progress_bar() {
    local duration=$1
    local steps=30
    local count=0
    printf "${YELLOW}["
    while [ $count -lt $steps ]; do
        sleep $((duration / steps))
        printf "▓"
        count=$((count + 1))
    done
    printf "] ${GREEN}Done!${RESET}\n"
}

# Print credits
echo -e "${PURPLE}─────────────────────────────────────────────${RESET}"
echo -e "${CYAN}        TermPika Setup Script by b0urn3${RESET}"
echo -e "${PURPLE}─────────────────────────────────────────────${RESET}"
echo -e "${GREEN}Credits: IG:onlybyhive${RESET}"
echo -e "${BLUE}Special thanks to contributors and the open-source community!${RESET}"
echo -e "${PURPLE}─────────────────────────────────────────────${RESET}\n"

# ZSH installation check and install
is_zsh_installed() {
    command -v zsh >/dev/null 2>&1
}

install_zsh() {
    if ! is_zsh_installed; then
        echo -e "${YELLOW}Installing ZSH...${RESET}"
        (sudo apt install zsh -y >/dev/null 2>&1) &
        progress_bar 5
    else
        echo -e "${GREEN}ZSH is already installed.${RESET}"
    fi
}

# Switch to ZSH shell
switch_to_zsh() {
    if [[ "$SHELL" != "/bin/zsh" ]]; then
        echo -e "${YELLOW}Switching to ZSH as default shell...${RESET}"
        (chsh -s /bin/zsh "$USER" >/dev/null 2>&1) &
        progress_bar 5
    else
        echo -e "${GREEN}ZSH is already the default shell.${RESET}"
    fi
}

# Clone repository
clone_repo() {
    echo -e "${YELLOW}Cloning repository...${RESET}"
    (git clone "$1" "$2" >/dev/null 2>&1) &
    progress_bar 5
}

# Compile and rename executable
compile_and_rename() {
    echo -e "${YELLOW}Compiling C code...${RESET}"
    (cd "$1" && gcc -o term terminalpika.c >/dev/null 2>&1) &
    progress_bar 5
}

# Move the executable to /usr/bin
move_executable() {
    echo -e "${YELLOW}Moving executable to /usr/bin...${RESET}"
    (sudo mv "$1/term" "/usr/bin/term" >/dev/null 2>&1) &
    progress_bar 5
}

# Replace .zshrc
replace_zshrc() {
    echo -e "${YELLOW}Replacing .zshrc configuration...${RESET}"
    [ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
    (cp "$1/.zshrc" "$HOME/.zshrc" >/dev/null 2>&1) &
    progress_bar 5
}

# Clean up repository folder
cleanup() {
    echo -e "${YELLOW}Cleaning up repository folder...${RESET}"
    rm -rf "$clone_dir"
    echo -e "${GREEN}Cleanup complete.${RESET}"
}

# Self-destruct (delete the script and its directory)
self_destruct() {
    echo -e "${RED}Self-destructing script and repository...${RESET}"
    rm -rf "$clone_dir"  # Remove the cloned pikazsh directory
    rm -- "$0"           # Delete the running script itself
    echo -e "${GREEN}Self-destruction complete.${RESET}"
}

# Main script logic
repo_url="https://github.com/q4n0/pikazsh.git"
clone_dir="pikazsh"

echo -e "${CYAN}Starting the TermPika setup...${RESET}"

install_zsh
switch_to_zsh
clone_repo "$repo_url" "$clone_dir"
compile_and_rename "$clone_dir"
move_executable "$clone_dir"
replace_zshrc "$clone_dir"

echo -e "${YELLOW}Sourcing new .zshrc configuration...${RESET}"
(source ~/.zshrc >/dev/null 2>&1) &
progress_bar 5

cleanup
self_destruct

echo -e "${GREEN}TermPika setup complete! Enjoy your customized terminal.${RESET}"
