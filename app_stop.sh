#!/bin/bash

## Usage
## For Stoping the Application Tomcat. Some times the Application Fails to stop to overcome this we are using this script.
## This script can be applied for any application that includes a inbuilt stop and start script.

# Set the Application user
APP_USER="tomcat" # Update the user as per server.
APP_DIR="/apps/tomcat/bin/" # Update the Application directory as per server.

# Change to the Tomcat bin directory
cd $APP_DIR

# Stop Tomcat with Inbuilt script
sudo -u $APP_USER ./shutdown.sh

# Wait for Tomcat to stop gracefully
sleep 5

# Check if Tomcat is still running
if sudo -u $APP_USER ps aux | grep org.apache.catalina.startup.Bootstrap | grep -v grep > /dev/null; then
    echo "Tomcat did not stop gracefully. Forcefully terminating the process..."
    PID=$(sudo -u $APP_USER ps aux | grep org.apache.catalina.startup.Bootstrap | grep -v grep | awk '{ print $2 }')
    sudo kill -9 $PID
	echo "Tomcat stopped"
else
    echo "Tomcat stopped gracefully."
fi
