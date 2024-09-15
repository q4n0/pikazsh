# Pikazsh
## TermPika Setup Script

**TermPika** is a bash script designed to automate the setup of your terminal environment. It ensures that ZSH is installed and configured, and provides a system-wide executable for terminal customization.

## Features

- **ZSH Installation**: Automatically installs ZSH if it is not already installed.
- **Shell Configuration**: Switches to ZSH as the default shell if it is not currently set.
- **Executable Setup**: Compiles and places a custom `term` executable in your system's PATH.
- **Configuration Update**: Replaces your `.zshrc` file with the one from the repository.
- **System Cleanup**: Removes all temporary files and directories created during the installation process.

## End Product

After running the `termpika.sh` script, you will have:

- **ZSH as Your Default Shell**: ZSH will be set as your default shell if it wasn’t already.
- **`term` Executable**: A compiled `term` executable will be available system-wide, accessible by typing `term` in your terminal.
- **Updated `.zshrc`**: Your `.zshrc` file will be replaced with the one from the repository.
- **Clean System**: Temporary files and directories used during installation will be deleted.

## Usage

1. **Download and Run the Script**:
   ```bash
   git clone https://github.com/q4n0/pikazsh/raw/main/termpika.sh
   sudo chmod +x pikazsh.sh
   sudo ./pikazsh.sh
