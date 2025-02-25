# Git Scripts Setup

This repository provides custom Git functions and aliases to enhance your Git workflows. Follow the instructions below to set up and use these scripts.

## Installation

1. **Download or Clone the Repository:**
   Ensure you have the Git install script (`git/install-script.sh`).

2. **Run the Install Script:**
   Navigate to the `git` directory and run:

   ```sh
   chmod +x install-script.sh
   ./install-script.sh
   ```

   This script will create a `git-scripts` directory in your home directory and update your `.zprofile` to source the Git scripts.

## Scripts and Aliases

The installation sets up the following functions and aliases:

- **Functions:**
  - `git_current_branch`: Displays the current Git branch.
  - `git_last_commit`: Shows the last commit on the current branch.
  - `git_summary`: Provides a summary of the repository status.
- **Aliases:**
  - `gmerge`: Pulls the latest changes and merges `origin/master`.
  - `gcreate`: Creates and checks out a new branch.
  - `gs`: Displays the Git status.
  - `ga`: Adds changes.
  - `gcb`: Shortcut for creating and switching to a new branch.
  - `gdiff`: Displays the Git diff.
  - `gcommit`: Commits with GPG signing.
  - `unstage`: Unstages changes.
  - `cleanup`: Prunes remote-tracking branches.
  - `oops`: Soft resets to the previous commit.
  - `gimmer`: Extracts the repository name from the remote URL.

## Usage

After installation, either open a new terminal or source your `.zprofile`:

```sh
source ~/.zprofile
```

Then, you can use the Git functions and aliases. For example:

- To display the current branch:

  ```sh
  git_current_branch
  ```

- To view a summary of your repository:

  ```sh
  git_summary
  ```

## Troubleshooting

- Ensure Git is installed.
- Verify that your `.zprofile` contains:

  ```sh
  source $HOME/git-scripts/git-scripts.sh
  ```

- If changes aren’t applied, re-source your `.zprofile`:

  ```sh
  source ~/.zprofile
  ```

## Contributing

Feel free to submit issues or pull requests to improve these scripts or add new features.

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE.
