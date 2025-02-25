#!/bin/bash
##
# @file install-script.sh
# @brief Installs Python utility functions and aliases for managing Python projects using Poetry and Pyenv.
##

# Check for Python dependency
if ! command -v python3 >/dev/null 2>&1; then
  echo "Error: python3 is required but not installed. Aborting."
  exit 1
fi

# Check for Poetry dependency
if ! command -v poetry >/dev/null 2>&1; then
  echo "Error: Poetry is required but not installed. Aborting."
  exit 1
fi

# Check for Pyenv dependency
if ! command -v pyenv >/dev/null 2>&1; then
  echo "Error: Pyenv is required but not installed. Aborting."
  exit 1
fi

# Define installation directory for Python scripts
INSTALL_DIR="$HOME/python-scripts"
mkdir -p "$INSTALL_DIR"

# Create python-scripts.sh file
cat << 'EOF' > "$INSTALL_DIR/python-scripts.sh"
#!/bin/bash
##
# @file python-scripts.sh
# @brief Provides useful Python functions and aliases for managing Python projects using Poetry and Pyenv.
##

##
# Creates a new Poetry project.
#
# @param project_name The name of the project.
create_poetry_project() {
  if [ -z "$1" ]; then
    echo "Usage: create_poetry_project <project_name>"
    return 1
  fi
  poetry new "$1"
  echo "Created new Poetry project: $1"
}

##
# Installs dependencies for a Poetry project.
#
# @param project_dir The directory of the project (default: current directory).
poetry_install() {
  local project_dir="${1:-.}"
  (cd "$project_dir" && poetry install)
  echo "Installed dependencies for project in $project_dir"
}

##
# Activates the Poetry shell for the current project.
poetry_shell() {
  poetry shell
}

##
# Sets the local Python version using Pyenv.
#
# @param version The Python version to set locally.
pyenv_local() {
  if [ -z "$1" ]; then
    echo "Usage: pyenv_local <python_version>"
    return 1
  fi
  pyenv local "$1"
  echo "Set local Python version to $1"
}
EOF

# Make python-scripts.sh executable
chmod +x "$INSTALL_DIR/python-scripts.sh"

# Update .zprofile to include Python scripts if not already added
if ! grep -q 'python-scripts' "$HOME/.zprofile"; then
  cat << EOF >> "$HOME/.zprofile"

# Python Scripts (Poetry & Pyenv)
source \$HOME/python-scripts/python-scripts.sh

alias create_poetry="create_poetry_project"
alias install_poetry="poetry_install"
alias poetry_shell="poetry_shell"
alias pyenv_local="pyenv_local"
EOF
fi

# Source .zprofile to apply changes
source "$HOME/.zprofile"

echo "Python scripts (Poetry & Pyenv) installed and aliases added to .zprofile"
