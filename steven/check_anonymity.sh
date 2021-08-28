#!/bin/bash

# Checks if current user is anonymous by checking the location of current IP

# Check user's real location
read -p "What is your current PHYSICAL location (ISO Country code): " REAL
echo "You have inputted $REAL"

# Check user's IP location
LOCATION=$(whois $(curl -s ifconfig.me) | grep -i country | head -n 1 | awk '{print $NF}')
echo "Your current location based on your IP address is $LOCATION"

# Tells user if he/she is anonymous or not
if [ "$REAL" == "$LOCATION" ]
then
	echo "You are NOT anonymous, please connect to a VPN before continuing"
else
	echo "You are anonymous!"
fi
