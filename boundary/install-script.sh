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
    local STATUS=$(boundary authenticate oidc -auth-method-id $BOUNDARY_AUTH_METHOD_ID -format=json | jq -r '.auth_token | select(. != null)')
    if [ -z "$STATUS" ]; then
        echo "Authentication required. Please reauthenticate."
        authenticate
    else
        echo "Already authenticated."
    fi
}
EOF

# Create start-rds.sh script
cat << 'EOF' > "$INSTALL_DIR/start-rds.sh"
#!/bin/bash

source "$HOME/boundary-scripts/authb.sh"

while true; do
    check_auth
    TARGET_ID=$(boundary targets list -format=json -scope-id=$(boundary scopes list -format=json | jq -r '.items[] | select(.name=="Data") | .id') | jq -r '.items[] | select(.name=="RDS") | .id')
    boundary connect -listen-port=$BOUNDARY_RDS_PORT -target-id=$TARGET_ID
    sleep 1
done
EOF

# Create start-trino.sh script
cat << 'EOF' > "$INSTALL_DIR/start-trino.sh"
#!/bin/bash

source "$HOME/boundary-scripts/authb.sh"

while true; do
    check_auth
    TARGET_ID=$(boundary targets list -format=json -scope-id=$(boundary scopes list -format=json | jq -r '.items[] | select(.name=="Data") | .id') | jq -r '.items[] | select(.name=="Trino") | .id')
    boundary connect -listen-port=8080 -target-id=$TARGET_ID
    sleep 1
done
EOF

# Make scripts executable
chmod +x "$INSTALL_DIR/authb.sh" "$INSTALL_DIR/start-rds.sh" "$INSTALL_DIR/start-trino.sh"

# Update .zprofile to include aliases
if ! grep -q 'boundary-scripts' "$HOME/.zprofile"; then
  cat << EOF >> "$HOME/.zprofile"

# Boundary Scripts
alias authb="source $HOME/boundary-scripts/authb.sh"
alias start-rds="bash $HOME/boundary-scripts/start-rds.sh"
alias start-trino="bash $HOME/boundary-scripts/start-trino.sh"
EOF
fi

# Source .zprofile to apply changes
source "$HOME/.zprofile"

echo "Boundary scripts installed and aliases added to .zprofile"
