#!/bin/bash
##
# @file docker/install-script.sh
# @brief Installs Docker scripts and aliases for common Docker operations.
##

# Check for Docker dependency
if ! command -v docker >/dev/null; then
  echo "Error: 'docker' is required but not installed. Aborting."
  exit 1
fi

# Define installation directory for Docker scripts
INSTALL_DIR="$HOME/docker-scripts"
mkdir -p "$INSTALL_DIR"

# Create docker-scripts.sh file
cat << 'EOF' > "$INSTALL_DIR/docker-scripts.sh"
#!/bin/bash
##
# @file docker-scripts.sh
# @brief Provides useful Docker functions and aliases.
##

##
# Cleans up dangling Docker images.
#
# @return void
docker_clean_images() {
  docker rmi $(docker images -a --filter=dangling=true -q)
}

##
# Removes containers with status exited or created.
#
# @return void
docker_clean_containers() {
  docker rm $(docker ps --filter=status=exited --filter=status=created -q)
}

##
# Prunes the entire Docker system (images, containers, volumes, and networks).
#
# @return void
docker_system_prune() {
  docker system prune -af
}

##
# Restarts a Docker container.
#
# @param container_id The ID or name of the Docker container.
# @return void
docker_restart_container() {
  local container_id="$1"
  docker restart "$container_id"
}

##
# Lists running Docker containers in a formatted table.
#
# @return void
docker_list() {
  docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"
}

##
# Tails the logs of a Docker container.
#
# @param container The container ID or name.
docker_tail_logs() {
  docker logs -f "$1"
}

# Aliases for convenience
alias docker_clean_images="docker_clean_images"
alias docker_clean_containers="docker_clean_containers"
alias docker_prune="docker_system_prune"
alias docker_restart="docker_restart_container"
alias docker_ls="docker_list"
alias dcup="docker-compose up -d"
alias dcd="docker-compose down"
alias dclogs="docker-compose logs -f"
alias dcrun="docker-compose run --rm"
alias dce="docker-compose exec"
alias dcb="docker-compose build"
alias dcp="docker-compose pull"
alias dcrestart="docker-compose restart"
alias dcls="docker-compose ps"
alias dcl="docker-compose logs"
alias dcrm="docker-compose rm"
alias dcv="docker-compose -v"
EOF

# Make docker-scripts.sh executable
chmod +x "$INSTALL_DIR/docker-scripts.sh"

# Update .zprofile to include Docker scripts if not already added
if ! grep -q 'docker-scripts' "$HOME/.zprofile"; then
  cat << EOF >> "$HOME/.zprofile"

# Docker Scripts
source \$HOME/docker-scripts/docker-scripts.sh
EOF
fi

# Source .zprofile to apply changes
source "$HOME/.zprofile"

echo "Docker scripts installed and aliases added to .zprofile"
