#!/bin/bash
##
# @file install-script.sh
# @brief Installs nvm (if not installed), the latest stable Node.js, and sets up useful Node functions and aliases.
##

set -e

# Check if nvm is installed
if ! command -v nvm >/dev/null 2>&1; then
  echo "nvm not found. Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

  # Source the shell configuration file to load nvm
  if [ -f "$HOME/.zshrc" ]; then
    echo "Sourcing ~/.zshrc..."
    source "$HOME/.zshrc"
  elif [ -f "$HOME/.bashrc" ]; then
    echo "Sourcing ~/.bashrc..."
    source "$HOME/.bashrc"
  else
    echo "Please source your shell configuration file manually to load nvm."
  fi
else
  echo "nvm is already installed."
fi

# Verify nvm is now available
if ! command -v nvm >/dev/null 2>&1; then
  echo "nvm installation failed or not loaded. Please check your shell configuration."
  exit 1
fi

echo "Installing the latest stable Node.js..."
nvm install node

echo "Setting the installed Node.js as the default version..."
nvm alias default node

# Create Node Scripts directory and file for additional functions/aliases
NODE_SCRIPTS_DIR="$HOME/node-scripts"
mkdir -p "$NODE_SCRIPTS_DIR"

cat << 'EOF' > "$NODE_SCRIPTS_DIR/node-scripts.sh"
#!/bin/bash
##
# @file node-scripts.sh
# @brief Provides useful functions and aliases for managing Node.js with nvm.
##

##
# Prints the currently active Node.js version.
node_current() {
  node -v
}

##
# Lists globally installed npm packages (top-level only).
npm_global_list() {
  npm ls -g --depth=0
}

##
# Installs a specific Node.js version using nvm.
# @param version The Node.js version to install.
nvm_install_version() {
  if [ -z "$1" ]; then
    echo "Usage: nvm_install_version <version>"
    return 1
  fi
  nvm install "$1"
}

##
# Switches to a specified Node.js version using nvm.
# @param version The Node.js version to switch to.
nvm_use_version() {
  if [ -z "$1" ]; then
    echo "Usage: nvm_use_version <version>"
    return 1
  fi
  nvm use "$1"
}

##
# Sets the default Node.js version using nvm.
# @param version The Node.js version to set as default.
nvm_set_default() {
  if [ -z "$1" ]; then
    echo "Usage: nvm_set_default <version>"
    return 1
  fi
  nvm alias default "$1"
}
EOF

chmod +x "$NODE_SCRIPTS_DIR/node-scripts.sh"

# Update .zprofile to source Node scripts and add aliases if not already added
if ! grep -q 'node-scripts' "$HOME/.zprofile"; then
  cat << EOF >> "$HOME/.zprofile"

# Node Scripts
source \$HOME/node-scripts/node-scripts.sh

alias nodev="node_current"
alias npmls="npm_global_list"
alias nvm_install_version="nvm_install_version"
alias nvm_use_version="nvm_use_version"
alias nvm_default="nvm_set_default"
EOF
fi

# Source .zprofile to apply changes
source "$HOME/.zprofile"

echo "Node.js installation complete and Node scripts installed with aliases added to .zprofile."
