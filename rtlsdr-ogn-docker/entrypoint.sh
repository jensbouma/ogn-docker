#!/bin/bash

# Function to check service status
check_service_status() {
    # Command to check the status of the service (replace with your actual command)
    /opt/rtlsdr-ogn/rtlsdr-ogn status | grep -e STOPPED -e DEAD >/dev/null 2>&1
    return $?
}

# Main loop to monitor the service
while true; do
    # Check the status of the service
    check_service_status
    if [ $? -ne 1 ]; then
        echo "Service is not running. Starting the service..."
        /opt/rtlsdr-ogn/rtlsdr-ogn start
    fi

    # Sleep for 10 seconds before checking again
    sleep 10
done
