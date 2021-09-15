#!/bin/bash


IPX=$(curl -s ifconfig.co)
country=$(whois $IPX | grep -i country | awk '{print $2}' | head -n 1)
IPI=$(ifconfig | grep broadcast | awk '{print $2}')
IDG=$(route -n | grep UG | awk '{print $2}')

echo "My External IP is $IPX and it is from $country"
echo "My Internal IP is $IPI"
echo "My Internal Default Gateway is $IDG"
