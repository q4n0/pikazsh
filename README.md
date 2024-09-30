# PikaZsh
## Advanced Zsh Setup Script

**PikaZsh** is an advanced bash script designed to automate the setup of your terminal environment with Zsh. It ensures that Zsh is installed and configured, sets up Oh My Zsh with popular plugins, and provides flexibility for different Linux distributions.

## Features
- **Zsh Installation**: Automatically installs Zsh if it is not already present.
- **Shell Configuration**: Switches to Zsh as the default shell if it's not currently set.
- **Oh My Zsh Setup**: Installs and configures Oh My Zsh for an enhanced shell experience.
- **Plugin Installation**: Sets up popular Zsh plugins like syntax highlighting and autosuggestions.
- **Multi-Distribution Support**: Works with various package managers (apt, yum, pacman).
- **Backup Creation**: Backs up existing Zsh and Oh My Zsh configurations before making changes.
- **Dry-Run Mode**: Allows previewing changes without applying them.
- **Verbose Logging**: Provides detailed output for troubleshooting and auditing.

## End Product
After running the `pikazsh.sh` script, you will have:
- **Zsh as Your Default Shell**: Zsh will be set as your default shell if it wasn't already.
- **Oh My Zsh Installed**: A fully configured Oh My Zsh setup.
- **Popular Plugins**: Syntax highlighting and autosuggestions plugins installed and configured.
- **Backup of Previous Setup**: Your original Zsh configuration safely backed up.
- **Detailed Log**: A log file of all operations performed during setup.

## Usage
1. **Download the Script**:
   ```bash
   wget https://raw.githubusercontent.com/q4n0/pikazsh/main/pikazsh.sh
   ```

2. **Make it Executable**:
   ```bash
   chmod +x pikazsh.sh
   ```

3. **Run the Script**:
   ```bash
   sudo ./pikazsh.sh
   ```

### Command-line Options
- `-d` or `--dry-run`: Perform a dry run without making any changes
- `-v` or `--verbose`: Enable verbose output
- `-h` or `--help`: Display usage information

## What the Script Does
1. Checks and installs the appropriate package manager
2. Backs up existing Zsh and Oh My Zsh configurations
3. Installs Zsh if not already present
4. Changes the default shell to Zsh
5. Installs Oh My Zsh
6. Installs and configures Zsh plugins

## Logging and Backup
- A log file is generated at `/tmp/zsh_setup_YYYYMMDD_HHMMSS.log`
- Backups are created in `$HOME/.zsh_setup_backup_YYYYMMDD_HHMMSS/`

## Troubleshooting
If you encounter any issues, please check the log file for detailed information. You can also run the script with the `-v` option for verbose output.

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
This script is released under the MIT License. See the LICENSE file for details.

## Disclaimer
This script modifies system settings and installs software. While it includes safety checks and backups, please review the script and use it at your own risk.
