#!/bin/bash

# Get information from a given domain name
DOMAIN=$1

# Get IP address and echo it
IP=$(host $DOMAIN | head -n 1 | awk '{print $(NF)}')
echo "The IP address of the given domain is $IP"

# Extract domain name without https, .com, etc (TODO later)

# Save who is data from IP address into file (name of file is the domain name)
whois $IP > $DOMAIN.txt
echo "The whois information has been saved in '$DOMAIN.txt'"
