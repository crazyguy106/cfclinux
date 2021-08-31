#!/bin/bash

# Get information of ip address using who is
echo "Please enter an IP address"
read ip

whois $ip
