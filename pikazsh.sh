#!/bin/bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

echo -e "${YELLOW}Warning:${RESET} This script is intended for Linux systems. Running this script on other operating systems may not work as expected."

echo -e "${GREEN}Credits:${RESET}"
echo -e "This script and project were developed by b0urn3. IG:onlybyhive"
echo -e "Special thanks to the contributors and open-source community for their tools and resources."

is_zsh_installed() {
    command -v zsh >/dev/null 2>&1
}

is_gcc_installed() {
    command -v gcc >/dev/null 2>&1
}

install_zsh() {
    if ! is_zsh_installed; then
        echo -n -e "${YELLOW}Installing ZSH...${RESET}"
        (sudo apt update -y >/dev/null 2>&1) && (sudo apt install zsh -y >/dev/null 2>&1) & progress_bar
        if [ $? -ne 0 ]; then
            echo -e "${RED}Failed to install ZSH. Exiting.${RESET}"
            exit 1
        fi
        echo -e "${GREEN} Done!${RESET}"
    else
        echo -e "${GREEN}ZSH is already installed.${RESET} \xE2\x9C\x94"
    fi
}

switch_to_zsh() {
    if [[ "$SHELL" != "/bin/zsh" ]]; then
        echo -n -e "${YELLOW}Switching to ZSH...${RESET}"
        (chsh -s /bin/zsh "$USER" >/dev/null 2>&1) & progress_bar
        if [ $? -ne 0 ]; then
            echo -e "${RED}Failed to switch to ZSH. Exiting.${RESET}"
            exit 1
        fi
        echo -e "${GREEN} Done!${RESET}"
    else
        echo -e "${GREEN}ZSH is already the default shell.${RESET} \xE2\x9C\x94"
    fi
}

clone_repo() {
    echo -n -e "${YELLOW}Cloning repository...${RESET}"
    (git clone "$1" "$2" >/dev/null 2>&1) & progress_bar
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to clone repository. Exiting.${RESET}"
        exit 1
    fi
    echo -e "${GREEN} Done!${RESET}"
}

compile_and_rename() {
    if ! is_gcc_installed; then
        echo -e "${RED}GCC is not installed. Please install GCC and try again.${RESET}"
        exit 1
    fi
    echo -n -e "${YELLOW}Compiling C code...${RESET}"
    (cd "$1" && gcc -o term terminalpika.c >/dev/null 2>&1) & progress_bar
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to compile C code. Exiting.${RESET}"
        exit 1
    fi
    echo -e "${GREEN} Done!${RESET}"
}

move_executable() {
    echo -n -e "${YELLOW}Moving executable to /usr/bin...${RESET}"
    (sudo mv "$1/term" "/usr/bin/term" >/dev/null 2>&1) & progress_bar
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to move executable. Exiting.${RESET}"
        exit 1
    fi
    echo -e "${GREEN} Done!${RESET}"
}

replace_zshrc() {
    echo -n -e "${YELLOW}Replacing .zshrc...${RESET}"
    if [ -f "$HOME/.zshrc" ]; then
        echo -e "${YELLOW}Backing up existing .zshrc to .zshrc.bak${RESET}"
        cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
    fi
    (cp "$1/.zshrc" "$HOME/.zshrc" >/dev/null 2>&1) & progress_bar
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to replace .zshrc. Exiting.${RESET}"
        exit 1
    fi
    echo -e "${GREEN} Done!${RESET}"
}

cleanup() {
    echo -n -e "${YELLOW}Cleaning up...${RESET}"
    rm -rf "$clone_dir"  # Remove the cloned repository directory
    echo -e "${GREEN} Done!${RESET}"
}

progress_bar() {
    local pid=$!
    local delay=0.1
    local bar_length=40
    local count=0
    local bar=""

    while ps -p $pid >/dev/null 2>&1; do
        bar="${bar}="
        count=$((count + 1))
        if [ "$count" -ge "$bar_length" ]; then
            count=0
            bar="${bar}#"
            echo -ne "\r[${bar}]"
        fi
        sleep $delay
    done
    echo -ne "\r[${bar} Done!]\n"
}

repo_url="https://github.com/q4n0/terminalpika.git"
clone_dir="cloned_repo"

install_zsh
switch_to_zsh
clone_repo "$repo_url" "$clone_dir"
compile_and_rename "$clone_dir"
move_executable "$clone_dir"
replace_zshrc "$clone_dir"

echo -n -e "${YELLOW}Sourcing .zshrc...${RESET}"
(source ~/.zshrc >/dev/null 2>&1) & progress_bar

cleanup

echo -e "${GREEN}Setup complete.${RESET}"

# Self-destruct the script and cloned repository
echo -e "${RED}Self-destructing...${RESET}"
rm -- "$0"  # Remove the script itself
rm -rf "$clone_dir"  # Remove the entire cloned repository

