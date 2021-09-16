#!/bin/bash

# Get location of user
read -p "[?] What is your current location? (Country): " current_loc

cd /home/kali/course/network_research/exercises/day2/nipe/

# Get IP location of user
IP=$(sudo perl nipe.pl status | grep Ip | awk '{print $NF}')
IP_loc=$(geoiplookup $IP | awk '{print $NF}')

# Check if real location is the same as IP location
if [ "$current_loc" != "$IP_loc" ]
then
	echo "You are already anonymous! You don't need my help... *sobs away*"
	cd ~-
	exit	
fi

# Activate TOR network
echo "You are not anonymous! I shall help you!"
sudo perl nipe.pl restart

# Get new IP location of user
new_IP=$(sudo perl nipe.pl status | grep Ip | awk '{print $NF}')
new_IP_loc=$(geoiplookup $new_IP | awk '{print $NF}')

echo "Your new IP address is $new_IP"
echo "You are now located in $new_IP_loc"
echo "You are now anonymous! Yay!"

cd ~-
