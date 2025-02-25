#!/bin/bash
##
# @file install-script.sh
# @brief Installs Python utility functions and aliases for managing projects using uv.
##

# Check for uv dependency
if ! command -v uv >/dev/null 2>&1; then
  echo "Error: uv is required but not installed. Please install it from: https://astral.sh/uv/install.sh"
  exit 1
fi

# Define installation directory for Python scripts
INSTALL_DIR="$HOME/python-scripts"
mkdir -p "$INSTALL_DIR"

# Create python-scripts.sh file with uv functions
cat << 'EOF' > "$INSTALL_DIR/python-scripts.sh"
#!/bin/bash
##
# @file python-scripts.sh
# @brief Provides useful Python functions and aliases for managing projects using uv.
##

##
# Initializes a new uv project.
#
# @param project_name The name of the project.
create_uv_project() {
  if [ -z "$1" ]; then
    echo "Usage: create_uv_project <project_name>"
    return 1
  fi
  uv init "$1"
  echo "Created new uv project: $1"
}

##
# Creates a virtual environment with uv using a specific Python version.
#
# @param python_version The Python version to use (e.g., 3.12.0).
create_uv_venv() {
  if [ -z "$1" ]; then
    echo "Usage: create_uv_venv <python_version>"
    return 1
  fi
  uv venv .venv --python "$1"
  echo "Created virtual environment with Python $1. Activate it with: source .venv/bin/activate"
}

##
# Adds a package using uv.
#
# @param package The package name (and optionally version).
# @param flags Additional flags (e.g., --dev, --optional <group>).
uv_add() {
  if [ -z "$1" ]; then
    echo "Usage: uv_add <package> [flags]"
    return 1
  fi
  uv add "$@"
}

##
# Installs a tool using uv.
#
# @param tool The name of the tool.
uv_tool_install() {
  if [ -z "$1" ]; then
    echo "Usage: uv_tool_install <tool>"
    return 1
  fi
  uv tool install "$1"
}

##
# Synchronizes the project environment using uv.
#
# @param options Additional options for uv sync.
uv_sync() {
  uv sync "$@"
}

##
# Compiles the dependency graph using uv.
uv_compile() {
  uv pip compile pyproject.toml
}
EOF

# Make python-scripts.sh executable
chmod +x "$INSTALL_DIR/python-scripts.sh"

# Update .zprofile to include Python scripts if not already added
if ! grep -q 'python-scripts' "$HOME/.zprofile"; then
  cat << EOF >> "$HOME/.zprofile"

# Python Scripts (uv)
source \$HOME/python-scripts/python-scripts.sh

alias create_uv="create_uv_project"
alias uv_venv="create_uv_venv"
alias uv_add="uv_add"
alias uv_tool_install="uv_tool_install"
alias uv_sync="uv_sync"
alias uv_compile="uv_compile"
EOF
fi

# Source .zprofile to apply changes
source "$HOME/.zprofile"

echo "Python scripts (uv) installed and aliases added to .zprofile"
