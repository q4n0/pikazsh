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
echo -e "\nWelcome to TerminalPika Setup!"
echo "This script requires sudo privileges to run successfully."
echo "Please enter your password if prompted."

# Set URLs for files
ZSHRC_URL="https://raw.githubusercontent.com/q4n0/terminalpika/main/zshrc"
TERMPIKA_C_URL="https://raw.githubusercontent.com/q4n0/terminalpika/main/termpika.c"

# Download new .zshrc
echo "Downloading new .zshrc..."
curl -o ~/.zshrc $ZSHRC_URL

# Download termpika.c
echo "Downloading termpika.c..."
curl -o termpika.c $TERMPIKA_C_URL

# Compile termpika.c
echo "Compiling termpika.c..."
gcc -o term termpika.c
if [ $? -ne 0 ]; then
    echo "Compilation failed. Please check the errors above."
    exit 1
fi

# Move the binary to /usr/bin
echo "Moving term to /usr/bin..."
mv term /usr/bin/

# Clean up downloaded files
echo "Cleaning up..."
rm termpika.c

# Completion message
echo -e "Setup complete! You can now run 'term' in your terminal.\n"
