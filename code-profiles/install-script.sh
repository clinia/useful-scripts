#!/bin/bash
##
# @file install-script.sh
# @brief Imports VS Code profiles saved as .code-profile files into VS Code.
##

# Verify that the 'code' command is available.
if ! command -v code >/dev/null 2>&1; then
  echo "Error: VS Code 'code' command not found. Please install VS Code and add it to your PATH."
  exit 1
fi

# Directory where this script and the .code-profile files reside.
SCRIPT_DIR="$(dirname "$0")"

# Find all .code-profile files in the script directory.
profile_files=("$SCRIPT_DIR"/*.code-profile)

if [ ${#profile_files[@]} -eq 0 ]; then
  echo "No .code-profile files found in $SCRIPT_DIR. Please add your profile files."
  exit 1
fi

# Import each profile using VS Code's CLI.
for profile in "${profile_files[@]}"; do
  echo "Importing profile: $profile"
  code --import-profile "$profile"
  if [ $? -ne 0 ]; then
    echo "Failed to import profile: $profile"
  else
    echo "Successfully imported profile: $profile"
  fi
done

echo "VS Code profiles import complete."
