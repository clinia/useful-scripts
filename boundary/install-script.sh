#!/bin/bash

# Append Boundary functions to .zprofile and source it
./shell-profile.sh
source ~/.zprofile

# Define variables
PLIST_NAME="com.$USER.start-rds.plist"
PLIST_PATH="$HOME/Library/LaunchAgents/$PLIST_NAME"
SCRIPT_PATH="$HOME/path/to/start-rds.sh"
LOG_PATH="$HOME/Library/Logs/start-rds"
STDOUT_LOG="$LOG_PATH.out"
STDERR_LOG="$LOG_PATH.err"

# Create Logs directory if it doesn't exist
mkdir -p $HOME/Library/Logs

# Create LaunchAgents directory if it doesn't exist
mkdir -p $HOME/Library/LaunchAgents

# Create the plist file
cat > $PLIST_PATH << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>$PLIST_NAME</string>
    <key>ProgramArguments</key>
    <array>
        <string>$SCRIPT_PATH</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>$STDOUT_LOG</string>
    <key>StandardErrorPath</key>
    <string>$STDERR_LOG</string>
</dict>
</plist>
EOF

# Set permissions
chmod 644 $PLIST_PATH

# Load the plist into launchctl
launchctl load $PLIST_PATH

# Start the service
launchctl start $PLIST_NAME

echo "Installation completed. Your service is now set up and running."
