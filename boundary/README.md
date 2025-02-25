# Boundary Scripts Setup

This repository contains scripts to manage Boundary authentication and secure connections for RDS, Trino, and Dedalus (FHIR) services. Follow the instructions below to set up and use the scripts.

## Installation

1. Clone the repository or download the install script.
2. Run the install script to set up the necessary files and aliases.

### Steps to Install

1. **Download the Install Script**

   Save the `install-script.sh` script to your local machine.

2. **Make the Script Executable**

   Open your terminal and navigate to the directory where you saved the script. Run the following command to make the script executable:

   ```sh
   chmod +x install-script.sh
   ```

3. **Run the Install Script**

   Execute the script to set up the environment, scripts, and aliases:

   ```sh
   ./install-script.sh
   ```

   This will create the necessary scripts in the `~/boundary-scripts` directory, make them executable, and update your `.zprofile` to include the aliases.

## Scripts and Aliases

The installation script sets up the following scripts and aliases:

- **Scripts:**
  - `authb.sh`: Handles Boundary authentication and provides a centralized connection function.
  - `start-rds.sh`: Manages a secure connection to the RDS service.
  - `start-trino.sh`: Manages a secure connection to the Trino service.
  - `start-dedalus.sh`: Manages a secure connection to the FHIR target under the Retrieval scope.
- **Aliases:**
  - `authb`: Runs the Boundary authentication function.
  - `start-rds`: Starts the secure connection loop for the RDS service.
  - `start-trino`: Starts the secure connection loop for the Trino service.
  - `start-dedalus`: Starts the secure connection loop for the Dedalus (FHIR) service.
  - `kill_port`: Kills any process running on a specified port.

## Usage

After running the install script, you can use the following commands in your terminal:

### Authenticate with Boundary

```sh
authb
```

This command will authenticate with Boundary using the configured OIDC method.

### Start Secure Connections

- **RDS Service**

  ```sh
  start-rds
  ```

- **Trino Service**

  ```sh
  start-trino
  ```

- **Dedalus (FHIR) Service**

  ```sh
  start-dedalus
  ```

### Killing Processes on a Port

Use the `kill_port` function to terminate any process running on a specific port:

```sh
kill_port <port_number>
```

## Troubleshooting

If you encounter any issues, ensure that the scripts are executable and that your `.zprofile` has been updated correctly. You can manually source your `.zprofile` to apply the changes:

```sh
source ~/.zprofile
```

For further assistance, please refer to the script comments or contact the repository maintainer.

## Contributing

Feel free to submit issues or pull requests to improve these scripts or add new features.

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE. See the `LICENSE` file for details.
