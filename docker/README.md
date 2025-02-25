# Docker Scripts Setup

This repository provides custom Docker functions and aliases for common Docker operations. Follow the instructions below to set up and use these scripts.

## Installation

1. **Download or Clone the Repository:**
   Ensure you have the Docker install script (`docker/install-script.sh`).

2. **Run the Install Script:**
   Navigate to the `docker` directory and run:

   ```sh
   chmod +x install-script.sh
   ./install-script.sh
   ```

   This script will create a `docker-scripts` directory in your home directory and update your `.zprofile` to source the Docker scripts.

## Scripts and Aliases

The installation sets up the following functions and aliases:

- **Functions:**
  - `docker_clean_images`: Removes dangling Docker images.
  - `docker_clean_containers`: Removes containers with status `exited` or `created`.
  - `docker_system_prune`: Prunes the entire Docker system (images, containers, volumes, and networks).
  - `docker_restart_container`: Restarts a Docker container given its ID or name.
  - `docker_list`: Lists running Docker containers in a formatted table.
  - `docker_tail_logs`: Tails the logs of a Docker container.
- **Aliases:**
  - `docker_clean_images`: Alias for cleaning up dangling images.
  - `docker_clean_containers`: Alias for removing exited or created containers.
  - `docker_prune`: Alias for system-wide prune.
  - `docker_restart`: Alias for restarting a container.
  - `docker_ls`: Alias for listing containers.

## Usage

After installation, either open a new terminal or source your `.zprofile`:

```sh
source ~/.zprofile
```

Then, you can use the Docker functions and aliases. For example:

- To remove dangling images:

  ```sh
  docker_clean_images
  ```

- To prune the Docker system:

  ```sh
  docker_prune
  ```

## Troubleshooting

- Ensure Docker is installed.
- Verify that your `.zprofile` contains:

  ```sh
  source $HOME/docker-scripts/docker-scripts.sh
  ```

- If changes aren’t applied, re-source your `.zprofile`:

  ```sh
  source ~/.zprofile
  ```

## Contributing

Feel free to submit issues or pull requests to improve these scripts or add new features.

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE.
