# Boundary Connection Scripts

## Overview

This README provides instructions for setting up and using custom scripts to manage connections through Boundary. These scripts facilitate the authentication and management of secure connections to various development and data services using Boundary. This setup ensures that connections are automatically managed, and authentication is handled seamlessly.

## Prerequisites

- macOS with Z shell (zsh) as the default shell.
- Boundary CLI installed and configured on your system.
- jq installed on your system (for parsing JSON).
- Administrative access to modify `~/.zprofile` and create scheduled tasks.

## Files Included

- `start-rds.sh`: Script to establish a continuous Boundary connection to the RDS in the Data environment.
- `install-script.sh`: Installation script to set up environment variables and aliases.

## Installation

1. Clone the Repository or Download the Scripts.
2. Run the Installation Script. Open the Terminal, navigate to the directory containing install-script.sh, and run the following commands:

```bash
chmod +x install-script.sh
```

```bash
./install-script.sh
```

This script will automatically append necessary environment variables, functions, and aliases to your `~/.zprofile`.
4. Reload your zsh profileAfter running the installation script, reload your `~/.zprofile` to apply the changes:

```bash
source ~/.zprofile
```

## Script Usage

Each script and alias has a specific purpose:

- `start-rds`: Initiates and maintains a continuous Boundary connection to the Data RDS.
- `start-trino`: Manages the connection to the Trino service in the Data scope.
- `authenticate`: Re-authenticates with Boundary if the session token expires.

To use the aliases set up by the installation script, simply type the alias name in your terminal. For example:

```bash
start-rds
```

## Custom Functions

`get_target_id(scope_name, target_name)`: Retrieves the target ID for a specified service within a given scope.
`date_to_epoch(date_str)`: Converts a specified date string to epoch time.
`check_token_expiry()`: Checks if the Boundary authentication token is about to expire and notifies the user.

## Additional Information

- Ensure you have the necessary permissions to execute scripts and manage services on your system.
- For detailed logs regarding the execution and any errors, refer to the specified log files set in the plist file (e.g., /tmp/start-rds.out).

## Conclusion

This README template is structured to guide users through setting up and using custom scripts for managing Boundary connections on macOS. Adjust the content as necessary to better fit your specific environment or additional tools involved.
