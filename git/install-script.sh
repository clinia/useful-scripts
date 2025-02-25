#!/bin/bash
##
# @file git/install-script.sh
# @brief Installs Git scripts and aliases for enhanced Git workflows.
##

# Check for Git dependency
if ! command -v git >/dev/null; then
  echo "Error: 'git' is required but not installed. Aborting."
  exit 1
fi

# Define installation directory for Git scripts
INSTALL_DIR="$HOME/git-scripts"
mkdir -p "$INSTALL_DIR"

# Create git-scripts.sh file
cat << 'EOF' > "$INSTALL_DIR/git-scripts.sh"
#!/bin/bash
##
# @file git-scripts.sh
# @brief Provides useful Git functions and aliases.
##

##
# Displays the current Git branch.
#
# @return void
git_current_branch() {
  git rev-parse --abbrev-ref HEAD
}

##
# Shows the last commit in the current branch.
#
# @return void
git_last_commit() {
  git log -1 --oneline
}

##
# Shows a summary of the repository status.
#
# @return void
git_summary() {
  echo "Branch: $(git_current_branch)"
  echo "Last commit: $(git_last_commit)"
}

##
# Stashes current changes with an optional message.
#
# @param message The message for the stash.
git_stash() {
  git stash push -m "${1:-"Quick stash"}"
}

##
# Lists all stashes.
git_stash_list() {
  git stash list
}

##
# Applies a specified stash.
#
# @param stash The stash reference (e.g., stash@{0}).
git_stash_apply() {
  git stash apply "$1"
}


##
# Switches to a different branch using fzf.
#
# @return void
git_switch() {
  local branch
  branch=$(git branch | sed 's/* //' | fzf --prompt="Switch to branch > ")
  if [ -n "$branch" ]; then
    git checkout "$branch"
  fi
}

##
# Alias: gmerge - Pulls latest changes and merges origin/master.
##
alias gmerge="git pull && git merge origin/master"

##
# Alias: gcreate - Creates and checks out a new branch.
##
alias gcreate="git checkout -b"

##
# Alias: gs - Displays the Git status.
##
alias gs="git status"

##
# Alias: ga - Adds changes.
##
alias ga="git add"

##
# Alias: gcb - Shortcut for creating and switching to a new branch.
##
alias gcb="git checkout -b"

##
# Alias: gdiff - Displays the Git diff.
##
alias gdiff="git diff"

##
# Alias: gcommit - Commits with GPG signing.
##
alias gcommit="git commit -S -m"

##
# Alias: unstage - Unstages changes.
##
alias unstage="git restore --staged ."

##
# Alias: cleanup - Prunes remote-tracking branches.
##
alias cleanup="git remote prune origin"

##
# Alias: oops - Soft resets to the previous commit.
##
alias oops="git reset --soft HEAD~"

##
# Alias: repo - Extracts the repository name from the remote URL.
##
alias repo="git remote -v | head -n1 | awk '{print \$2}' | sed -e 's,.*:\(.*/\)\?,,' -e 's/\.git\$//'"
EOF

# Make git-scripts.sh executable
chmod +x "$INSTALL_DIR/git-scripts.sh"

# Update .zprofile to include Git scripts if not already added
if ! grep -q 'git-scripts' "$HOME/.zprofile"; then
  cat << EOF >> "$HOME/.zprofile"

# Git Scripts
source \$HOME/git-scripts/git-scripts.sh
EOF
fi

# Source .zprofile to apply changes
source "$HOME/.zprofile"

echo "Git scripts installed and aliases added to .zprofile"
