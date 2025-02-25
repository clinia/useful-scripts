# VS Code Profiles Setup

This script imports custom VS Code profiles saved as `.code-profile` files into your VS Code installation. For example, if you have a `Typescript.code-profile` file, it will be imported via VS Code's CLI.

## Installation

1. **Download or Clone the Repository:**
   Ensure that the `install-script.sh` file and your `.code-profile` files (e.g. `Typescript.code-profile`) are located in the `vscode` directory.

2. **Make the Install Script Executable:**
   Open your terminal, navigate to the `vscode` directory, and run:

   ```sh
   chmod +x install-script.sh
   ```

3. **Run the Install Script:**
   Execute the script to import your VS Code profiles:

   ```sh
   ./install-script.sh
   ```

   The script will:
   - Verify that the VS Code CLI (`code`) is available.
   - Search for all `.code-profile` files in the directory.
   - Import each profile using the `code --import-profile` command.

## Customization

- **Profile Files:**
  Add or modify any `.code-profile` files in this directory. For example, you might have a `Typescript.code-profile` file that configures your preferred settings for TypeScript development.

- **VS Code CLI:**
  Ensure that the `code` command is added to your PATH. If not, refer to [VS Code documentation](https://code.visualstudio.com/docs/editor/command-line) for instructions.

## Troubleshooting

- **Command Not Found:**
  If the script complains that `code` is not found, ensure that VS Code is installed and the CLI is accessible.

- **Import Failures:**
  If a profile fails to import, check that the profile file is correctly formatted and valid.

## Contributing

Feel free to submit issues or pull requests to improve these scripts or add new features.

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE.
