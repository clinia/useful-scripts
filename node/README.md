# Node + nvm Setup

This directory provides an install script to set up Node.js using the Node Version Manager (nvm) along with additional functions and aliases to help manage your Node environment. nvm lets you easily install, manage, and switch between multiple Node.js versions.

## Installation

1. **Download or Clone the Repository:**
   Ensure you have the `install-script.sh` file in the `node` directory.

2. **Make the Script Executable:**

   ```bash
   chmod +x install-script.sh
   ```

3. **Run the Install Script:**

   ```bash
   ./install-script.sh
   ```

   The script will:
   - Check if nvm is installed and install it if missing.
   - Source your shell configuration (e.g., `~/.zshrc` or `~/.bashrc`) to load nvm.
   - Install the latest stable Node.js.
   - Set the installed Node.js version as the default.
   - Create a `node-scripts` directory with a `node-scripts.sh` file containing useful Node functions.
   - Update your `.zprofile` to source the Node scripts and add helpful aliases.

## Node Functions and Aliases

The installation sets up the following functions and aliases:

### Functions

- **node_current:**
  Prints the currently active Node.js version.

  ```bash
  node_current
  ```

- **npm_global_list:**
  Lists globally installed npm packages (top-level only).

  ```bash
  npm_global_list
  ```

- **nvm_install_version `<version>`:**
  Installs a specific Node.js version.

  ```bash
  nvm_install_version 22.14.0
  ```

- **nvm_use_version `<version>`:**
  Switches to a specified Node.js version.

  ```bash
  nvm_use_version 22.14.0
  ```

- **nvm_set_default `<version>`:**
  Sets the default Node.js version.

  ```bash
  nvm_set_default 22.14.0
  ```

### Aliases

- **nodev:** Alias for `node_current`.
- **npmls:** Alias for `npm_global_list`.
- **nvm_install_version:** Alias for `nvm_install_version`.
- **nvm_use_version:** Alias for `nvm_use_version`.
- **nvm_default:** Alias for `nvm_set_default`.

## Post-Installation

After running the install script, either open a new terminal or source your `.zprofile`:

```bash
source ~/.zprofile
```

## Troubleshooting

- **nvm Not Found:**
  If nvm is not found after running the script, ensure you have sourced your shell configuration (e.g., `source ~/.zshrc` or `source ~/.bashrc`) or restart your terminal.

- **Permission Issues:**
  Ensure the install script and the created files have executable permissions.

- **Customizing Aliases:**
  You can modify the aliases in your `.zprofile` if desired.

## Further Information

For more details on nvm, visit the [nvm repository](https://github.com/nvm-sh/nvm).

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE.
