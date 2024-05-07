#!/bin/bash

# Boundary connect loop
echo 'Running Boundary loop...'
while true; do
    start-rds
    if [ $? -ne 0 ]; then
        echo "Connection failed, trying to re-authenticate..."
        authenticate
    fi
done
