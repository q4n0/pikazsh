#!/bin/bash

# Define variables
GITHUB_REPO="https://github.com/q4n0/terminalpika"
ZSHRC_URL="$GITHUB_REPO/.zshrc"
TERMPIKA_URL="$GITHUB_REPO/termpika.c"
TERM_BIN="/usr/bin/term"

# Function to print banners
print_banner() {
    echo -e "\033[31m"  # Red color
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠶⠤⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡤⠶⠾⠷⠶⠶⣤⣈⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠀⠀⣠⠾⢁⣤⣴⣶⣶⣶⣶⣦⣤⡉⠛⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⢀⡾⢡⠞⠻⣿⣿⡿⢻⣿⣿⣿⣿⡿⠃⠀⠻⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⣾⢡⣿⠀⠀⣿⡟⠀⠀⣿⣿⣿⣿⣇⠀⠀⡀⢻⣆⣤⠶⠒⠒⠶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⣿⣾⣿⣄⣴⣿⣷⡀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣷⠘⣿⠧⣤⠻⠽⠂⢈⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⣠⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⢸⣿⡛⠛⣴⣲⠄⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⢰⡟⠁⠀⠈⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢡⡿⠙⢿⣦⣤⣤⣤⠾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⢸⡇⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢛⣵⠟⠀⠀⣼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠈⠻⣆⠀⠀⠀⠀⠀⣻⠾⢿⣿⣛⣛⣻⣯⣵⡾⠛⠁⠀⠀⢀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠙⠷⣄⣀⣀⣠⡿⠀⠀⠀⠀⠀⠀⠀⠀⢷⡀⠀⠀⢀⣾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    echo "⠀⠀⠀⠀⠈⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠳⠾⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\033[0m"  # Reset color
}

# Start script with welcome message
print_banner
echo -e "\033[32mWelcome to TerminalPika Setup!\033[0m"  # Green color
echo -e "\033[33mThis script requires sudo privileges to run successfully.\033[0m"  # Yellow color
echo "Please enter your password if prompted."

# Confirm using sudo
if [[ $EUID -ne 0 ]]; then
    echo -e "\033[31mYou need to run this script with sudo! Exiting...\033[0m"  # Red color
    exit 1
fi

# Backup existing .zshrc
if [ -f ~/.zshrc ]; then
    echo "Backing up existing .zshrc to ~/.zshrc.bak"
    cp ~/.zshrc ~/.zshrc.bak
fi

# Download new .zshrc from GitHub
echo "Downloading new .zshrc..."
curl -o ~/.zshrc $ZSHRC_URL

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Failed to download .zshrc from GitHub."
    exit 1
fi

# Download termpika.c
echo "Downloading termpika.c..."
curl -o ~/termpika.c $TERMPIKA_URL

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Failed to download termpika.c from GitHub."
    exit 1
fi

# Compile termpika.c
echo "Compiling termpika.c..."
gcc ~/termpika.c -o $TERM_BIN

# Check if compilation was successful
if [ $? -ne 0 ]; then
    echo "Compilation failed."
    exit 1
fi

# Change permissions to make the binary executable
chmod +x $TERM_BIN

# Cleanup downloaded files
rm ~/termpika.c

echo "Setup completed successfully!"
echo "You can now run 'term' in your terminal."
