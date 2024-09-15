# pikazsh
# TermPika Setup Script

**TermPika** is a bash script that automates the setup of your terminal environment with the following features:

- **ZSH Installation**:
- **Shell Configuration**: 

## End Product

Once you run the `termpika.sh` script, you will have:

- **ZSH as Your Default Shell**: If ZSH wasn't already your default shell, it will be switched automatically.
- **`term` Executable**: A compiled `term` executable will be available system-wide, which you can run by typing `term` in your terminal.
- **Updated `.zshrc`**: Your `.zshrc` file will be updated with configurations from the repository.
- **Clean System**: All temporary files and directories used during the installation process will be deleted.

## Usage

1. **Download and Run the Script**:
   ```bash
   wget https://github.com/q4n0/terminalpika/raw/main/termpika.sh
   chmod +x termpika.sh
   ./termpika.sh
