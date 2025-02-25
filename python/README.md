# Python Scripts Setup

This directory provides custom Python utility functions and aliases to help manage Python projects using either **Poetry & Pyenv** or **uv**. Both approaches are supported—choose the one that best fits your workflow.

---

## Option 1: Poetry & Pyenv

This approach uses [Poetry](https://python-poetry.org/docs/#installation) for dependency management and virtual environment handling, combined with [Pyenv](https://github.com/pyenv/pyenv) for managing local Python versions.

### Installation

1. **Download or Clone the Repository:**
   Ensure you have the install script `install-script-poetry-pyenv.sh`.

2. **Run the Install Script:**
   Navigate to the `python` directory and run:

   ```sh
   chmod +x install-script-poetry-pyenv.sh
   ./install-script-poetry-pyenv.sh
   ```

   This script will:
   - Create a `python-scripts` directory in your home directory.
   - Create a `python-scripts.sh` file with functions for managing Poetry projects and setting local Python versions with Pyenv.
   - Update your `.zprofile` to source the Python scripts and add useful aliases.

### Scripts and Aliases

**Functions:**

- `create_poetry_project <project_name>`: Creates a new Poetry project.
- `poetry_install [project_dir]`: Installs dependencies for a Poetry project (defaults to the current directory).
- `poetry_shell`: Activates the Poetry shell for the current project.
- `pyenv_local <python_version>`: Sets the local Python version using Pyenv.

**Aliases:**

- `create_poetry` — alias for `create_poetry_project`
- `install_poetry` — alias for `poetry_install`
- `poetry_shell` — alias for `poetry_shell`
- `pyenv_local` — alias for `pyenv_local`

### Usage

After installation, either open a new terminal or source your `.zprofile`:

```sh
source ~/.zprofile
```

**Examples:**

- Create a new project:

  ```sh
  create_poetry myproject
  ```

- Install project dependencies:

  ```sh
  install_poetry
  ```

  Or specify a directory:

  ```sh
  install_poetry myproject
  ```

- Activate the Poetry shell:

  ```sh
  poetry_shell
  ```

- Set a local Python version:

  ```sh
  pyenv_local 3.9.7
  ```

### Troubleshooting

- **Dependencies Not Found:**
  Ensure that Python3, Poetry, and Pyenv are installed on your system.

- **.zprofile Not Updated:**
  Verify that your `.zprofile` includes:

  ```sh
  source $HOME/python-scripts/python-scripts.sh
  ```

- **Permission Issues:**
  Ensure the install script and the created files have executable permissions.

---

## Option 2: uv

[uv](https://astral.sh/uv/) is an all-in-one tool that replaces both Pyenv and Poetry, offering fast dependency management and virtual environment handling.

### UV Installation

1. **Install uv:**
   Install uv with:

   ```bash
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

   To upgrade uv later, run:

   ```bash
   uv self update
   ```

2. **Download or Clone the Repository:**
   Ensure you have the install script `install-script-uv.sh` in the `python` directory.

3. **Run the Install Script:**
   Navigate to the `python` directory and run:

   ```sh
   chmod +x install-script-uv.sh
   ./install-script-uv.sh
   ```

   This script will:
   - Create a `python-scripts` directory in your home directory.
   - Create a `python-scripts.sh` file with functions for managing uv projects.
   - Update your `.zprofile` to source the Python scripts and add useful aliases.

### UV Scripts and Aliases

**Functions:**

- `create_uv_project <project_name>`: Initializes a new uv project.
- `create_uv_venv <python_version>`: Creates a virtual environment using uv with the specified Python version.
- `uv_add <package> [flags]`: Adds a package to your project (supports flags like `--dev` or `--optional <group>`).
- `uv_tool_install <tool>`: Installs a development tool via uv.
- `uv_sync [options]`: Synchronizes the project environment.
- `uv_compile`: Compiles the dependency graph from your `pyproject.toml`.

**Aliases:**

- `create_uv` — alias for `create_uv_project`
- `uv_venv` — alias for `create_uv_venv`
- `uv_add` — alias for `uv_add`
- `uv_tool_install` — alias for `uv_tool_install`
- `uv_sync` — alias for `uv_sync`
- `uv_compile` — alias for `uv_compile`

### UV Usage

After installation, either open a new terminal or source your `.zprofile`:

```sh
source ~/.zprofile
```

**Examples:**

- Initialize a new project:

  ```sh
  create_uv myproject
  ```

- Create a virtual environment with a specific Python version:

  ```sh
  uv_venv 3.12.0
  source .venv/bin/activate
  ```

- Add a package:

  ```sh
  uv_add torch
  ```

  For development dependencies:

  ```sh
  uv_add ruff pytest --dev
  ```

  For optional extras:

  ```sh
  uv_add cohere --optional optional_models
  ```

- Install a tool:

  ```sh
  uv_tool_install ruff
  ```

- Synchronize the environment:

  ```sh
  uv_sync
  ```

- Compile the dependency graph:

  ```sh
  uv_compile
  ```

### Advanced Usage

uv supports exporting a reproducible dependency file:

```bash
uv export --format requirements-txt --no-hashes --index https://download.pytorch.org/whl/cu121 --extra external_models -o requirements.txt
```

And synchronizing with all indexes considered:

```bash
uv pip sync --index-strategy unsafe-best-match --index https://download.pytorch.org/whl/cu121 requirements.txt
```

Refer to the [uv documentation](https://astral.sh/uv/) for more details.

### UV Troubleshooting

- **uv Command Not Found:**
  Ensure uv is installed and available in your PATH.

- **.zprofile Not Updated:**
  Verify that your `.zprofile` includes:

  ```sh
  source $HOME/python-scripts/python-scripts.sh
  ```

- **Permission Issues:**
  Ensure the install script and created files have executable permissions.

---

## Contributing

Feel free to submit issues or pull requests to improve these scripts or add new features.

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE.
