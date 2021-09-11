#!/bin/bash

#Create a code the will get a domain name and: 
#1.	Return the IP address
#2.	Save the whois data into a file (the name of the file should be the domain name)

#raw IP because there's still the annoying brackets
rip=$(ping -c 1 $1 | head -n 1 | awk '{print $3}')
#cleaning the IP address
ip=$(echo $rip | tr '()' ' ')

echo "The domain IP address is $ip" 
echo "And it will be put into a file named $1"

#Putting it into a file with the domain name
whois $ip > "$1"
