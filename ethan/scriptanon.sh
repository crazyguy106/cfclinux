#!/bin/bash

#Create a script to see if I'm anonymous or not

#This is my current IP
nowip=$(curl -s ifconfig.me)
#This shows you my current IP address
nowcountry=$(whois $nowip | grep -i country | head -n 1 | awk '{print $2}')

#If you're currently in SG (Singapore), you're currently not anonymous!
if [ "$nowcountry" == "SG" ]
then
echo "You're not anonymous!"
else
echo "You are anonymous."
fi
