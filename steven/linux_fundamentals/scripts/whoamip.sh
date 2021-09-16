#!/bin/bash

# Create a script that shows the user the Internap IP, default gateway, and external IP

echo "Internal IP Address"
ifconfig | grep broadcast | awk '{print $2}'

echo "Default Gateway"
route -n | grep UG | awk '{print $2}'

echo "External IP"
curl ifconfig.me
