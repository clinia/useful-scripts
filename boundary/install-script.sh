#!/bin/bash

# Define the installation directory
INSTALL_DIR="$HOME/boundary-scripts"
mkdir -p "$INSTALL_DIR"

# Create authb.sh script
cat << 'EOF' > "$INSTALL_DIR/authb.sh"
#!/bin/bash

export BOUNDARY_AUTH_METHOD_ID=amoidc_Gq5t6fwExE
export BOUNDARY_ADDR=https://boundary.clinia.dev
export BOUNDARY_SCOPE_ID=o_wwiZDNQyle
export BOUNDARY_RDS_PORT=5432

authenticate() {
    boundary authenticate oidc -auth-method-id $BOUNDARY_AUTH_METHOD_ID
}

check_auth() {
    # Attempt to list scopes to check if already authenticated
    local STATUS=$(boundary scopes list -recursive -format=json 2>&1)

    if echo "$STATUS" | grep -q 'error.*authentication required'; then
        echo "Authentication required. Please reauthenticate."
        authenticate
    else
        echo "Already authenticated."
    fi
}

start_rds() {
    while true; do
        check_auth
        SCOPE_ID=$(boundary scopes list -recursive -format=json | jq -r '.items[] | select(.name=="Data") | .id')
        TARGET_ID=$(boundary targets list -recursive -scope-id=$SCOPE_ID -format=json | jq -r '.items[] | select(.name=="RDS") | .id')
        boundary connect -listen-port=$BOUNDARY_RDS_PORT -target-id=$TARGET_ID
        sleep 1
    done
}

start_trino() {
    while true; do
        check_auth
        SCOPE_ID=$(boundary scopes list -recursive -format=json | jq -r '.items[] | select(.name=="Data") | .id')
        TARGET_ID=$(boundary targets list -recursive -scope-id=$SCOPE_ID -format=json | jq -r '.items[] | select(.name=="Trino") | .id')
        boundary connect -listen-port=8080 -target-id=$TARGET_ID
        sleep 1
    done
}
EOF

# Make scripts executable
chmod +x "$INSTALL_DIR/authb.sh"

# Update .zprofile to include aliases and source the authb.sh script
if ! grep -q 'boundary-scripts' "$HOME/.zprofile"; then
  cat << EOF >> "$HOME/.zprofile"

# Boundary Scripts
source $HOME/boundary-scripts/authb.sh

alias authb="authenticate"
alias start-rds="start_rds"
alias start-trino="start_trino"
EOF
fi

# Source .zprofile to apply changes
source "$HOME/.zprofile"

echo "Boundary scripts installed and aliases added to .zprofile"
