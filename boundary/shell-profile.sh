cat << 'EOF' >> ~/.zprofile
# Boundary
export BOUNDARY_AUTH_METHOD_ID=<method_id>
export BOUNDARY_ADDR=https://boundary.clinia.dev
export BOUNDARY_SCOPE_ID=o_wwiZDNQyle
export BOUNDARY_RDS_PORT=5434
# Function to get target ID by scope and target name
get_target_id() {
    local scope_name=$1
    local target_name=$2
    boundary targets list -format=json -scope-id=\$(boundary scopes list -format=json | jq -r --arg scope_name "\$scope_name" '.items[] | select(.name==\$scope_name) | .id') | jq -r --arg target_name "\$target_name" '.items[] | select(.name==\$target_name) | .id'
}
# Function to parse date string and convert it to epoch time
date_to_epoch() {
    local date_str=\$1
    local epoch_time=\$(date -jf "%Y-%m-%dT%H:%M:%S%z" "\$date_str" +%s 2>/dev/null || date -d "\$date_str" +%s 2>/dev/null)
    echo "\$epoch_time"
}
# Function to check if authentication token is expired
check_token_expiry() {
    local expiry=\$(boundary authenticate token-info -auth-method-id \$BOUNDARY_AUTH_METHOD_ID | jq -r '.expires_at')
    local current_time=\$(date +%s)
    local expiry_time=\$(date_to_epoch "\$expiry")
    local threshold=3600  # 1 hour threshold for expiry notification (adjust as needed)

    if (( \$expiry_time - \$current_time <= \$threshold )); then
        echo "Boundary authentication token is about to expire. Please run 'authenticate' to renew it."
    fi
}
authenticate() {
    echo "Authenticating..."
    boundary authenticate oidc -auth-method-id=\$BOUNDARY_AUTH_METHOD_ID
}
# Aliases
alias start-rds-dev="start_boundary_loop \$BOUNDARY_RDS_PORT 'Development' 'RDS'"
alias start-trino-dev="start_boundary_loop 8080 'Development' 'Trino'"
alias start-rds="start_boundary_loop \$BOUNDARY_RDS_PORT 'Data' 'RDS'"
alias start-trino="start_boundary_loop 8080 'Data' 'Trino'"
EOF
