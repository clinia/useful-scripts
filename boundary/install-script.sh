#!/bin/bash
##
# @file install-script.sh
# @brief Installs Boundary scripts, sets up aliases, and checks for dependencies.
##

# Check for required dependencies
for cmd in jq boundary lsof; do
  if ! command -v "$cmd" >/dev/null; then
    echo "Error: '$cmd' is required but not installed. Aborting."
    exit 1
  fi
done

# Define the installation directory
INSTALL_DIR="$HOME/boundary-scripts"
mkdir -p "$INSTALL_DIR"

# Create authb.sh script
cat << 'EOF' > "$INSTALL_DIR/authb.sh"
#!/bin/bash
##
# @file authb.sh
# @brief Provides Boundary authentication and connection functions.
##

export BOUNDARY_AUTH_METHOD_ID="amoidc_Ea0v2uSt5i"
export BOUNDARY_ADDR="https://boundary.clinia.dev"
export BOUNDARY_SCOPE_ID="o_wwiZDNQyle"
export BOUNDARY_RDS_PORT="5432"

##
# Authenticates with Boundary using OIDC.
#
# @return void
authenticate() {
  boundary authenticate oidc -auth-method-id "$BOUNDARY_AUTH_METHOD_ID"
}

##
# Checks authentication status and reauthenticates if needed.
#
# @return void
check_auth() {
  local status
  status=$(boundary scopes list -recursive -format=json 2>&1)
  if echo "$status" | grep -qi 'error.*authentication required'; then
    echo "Authentication required. Reauthenticating..."
    authenticate
  else
    echo "Already authenticated."
  fi
}

##
# Starts a connection to a specified Boundary target.
#
# @param scope_name Name of the scope.
# @param target_name Name of the target.
# @param listen_port Port number to listen on.
#
# @return void
start_connection() {
  local scope_name="$1"
  local target_name="$2"
  local listen_port="$3"

  while true; do
    check_auth
    local scope_id
    scope_id=$(boundary scopes list -recursive -format=json | jq -r ".items[] | select(.name==\"$scope_name\") | .id")
    local target_id
    target_id=$(boundary targets list -recursive -scope-id="$scope_id" -format=json | jq -r ".items[] | select(.name==\"$target_name\") | .id")
    boundary connect -listen-port="$listen_port" -target-id="$target_id"
    sleep 1
  done
}

##
# Kills any process listening on the specified port.
#
# @param port The port number to check.
# @return void
kill_port() {
  local port="$1"
  local pids
  pids=$(lsof -ti tcp:"$port")
  if [ -n "$pids" ]; then
    echo "Killing process(es) on port $port: $pids"
    kill -9 $pids
  else
    echo "No process found running on port $port."
  fi
}
EOF

# Create start-rds.sh script
cat << 'EOF' > "$INSTALL_DIR/start-rds.sh"
#!/bin/bash
##
# @file start-rds.sh
# @brief Initiates a connection to the RDS target under the Retrieval scope.
##
source "$HOME/boundary-scripts/authb.sh"
start_connection "Retrieval" "RDS" "$BOUNDARY_RDS_PORT"
EOF

# Create start-trino.sh script
cat << 'EOF' > "$INSTALL_DIR/start-trino.sh"
#!/bin/bash
##
# @file start-trino.sh
# @brief Initiates a connection to the Trino target under the Retrieval scope on port 8080.
##
source "$HOME/boundary-scripts/authb.sh"
start_connection "Retrieval" "Trino" 8080
EOF

# Make scripts executable
chmod +x "$INSTALL_DIR/authb.sh" "$INSTALL_DIR/start-rds.sh" "$INSTALL_DIR/start-trino.sh"

# Update .zprofile to include aliases and source the authb.sh script if not already added
if ! grep -q 'boundary-scripts' "$HOME/.zprofile"; then
  cat << EOF >> "$HOME/.zprofile"

# Boundary Scripts
source \$HOME/boundary-scripts/authb.sh

alias authb="authenticate"
alias start-rds="start_connection 'Retrieval' 'RDS' \$BOUNDARY_RDS_PORT"
alias start-trino="start_connection 'Retrieval' 'Trino' 8080"
alias kill_port="kill_port"
EOF
fi

# Source .zprofile to apply changes
source "$HOME/.zprofile"

echo "Boundary scripts installed and aliases added to .zprofile"
