# Python Scripts Setup (Poetry & Pyenv)

This directory provides custom Python utility functions and aliases to help manage Python projects using Poetry and Pyenv. These scripts simplify project creation, dependency installation, environment activation, and local Python version management.

## Installation

1. **Download or Clone the Repository:**
   Ensure you have the Python install script (`python/install-script.sh`).

2. **Run the Install Script:**
   Navigate to the `python` directory and run:

   ```sh
   chmod +x install-script.sh
   ./install-script.sh
   ```

   This script will:
   - Create a `python-scripts` directory in your home directory.
   - Create a `python-scripts.sh` file with functions for managing Poetry projects and setting local Python versions with Pyenv.
   - Update your `.zprofile` to source the Python scripts and add useful aliases.

## Scripts and Aliases

The installation sets up the following functions and aliases:

- **Functions:**
  - `create_poetry_project <project_name>`: Creates a new Poetry project with the specified project name.
  - `poetry_install [project_dir]`: Installs dependencies for a Poetry project. If no directory is specified, the current directory is used.
  - `poetry_shell`: Activates the Poetry shell for the current project.
  - `pyenv_local <python_version>`: Sets the local Python version using Pyenv.

- **Aliases:**
  - `create_poetry`: Alias for the `create_poetry_project` function.
  - `install_poetry`: Alias for the `poetry_install` function.
  - `poetry_shell`: Alias for the `poetry_shell` function.
  - `pyenv_local`: Alias for the `pyenv_local` function.

## Usage

After installation, open a new terminal or source your `.zprofile`:

```sh
source ~/.zprofile
```

### Examples:

- **Create a New Poetry Project:**

  ```sh
  create_poetry myproject
  ```

- **Install Project Dependencies:**

  ```sh
  install_poetry
  ```

  or specify a directory:

  ```sh
  install_poetry myproject
  ```

- **Activate the Poetry Shell:**

  ```sh
  poetry_shell
  ```

- **Set Local Python Version with Pyenv:**

  ```sh
  pyenv_local 3.9.7
  ```

## Troubleshooting

- **Dependencies Not Found:**
  Ensure that Python3, Poetry, and Pyenv are installed on your system.

- **.zprofile Not Updated:**
  Verify that your `.zprofile` includes:

  ```sh
  source $HOME/python-scripts/python-scripts.sh
  ```

- **Permission Issues:**
  Ensure the install script and the created files have executable permissions.

## Contributing

Feel free to submit issues or pull requests to improve these scripts or add new features.

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE.
