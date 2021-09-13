#!/bin/bash

#Create a script to see if I'm anonymous or not and turns on nip
PWD=$(pwd | awk -F/ '{print $NF}')
if [ "$PWD" != "/home/kali/nipe" ];
then
	echo "Wrong folder."
	exit
fi
#This is my current IP
nowip=$(curl -s ifconfig.me)
#This shows you my current IP address
nowcountry=$(whois $nowip | grep -i country | head -n 1 | awk '{print $2}')

#If you're currently in SG (Singapore), you're currently not anonymous!
if [ "$nowcountry" == "SG" ];
then
echo "You're not anonymous!"
echo "Turning on Nipe."
	while :
	do
	sudo perl nipe.pl start
	STATUS=$(sudo perl nipe.pl status | grep activated)
		if [ -z "$STATUS" ]
		then sudo perl nipe.pl restart
		else
		break
		fi
	done
echo "You are now anonymous."
NEWIP=$(curl -s ifconfig.me)
echo "Your new IP is: $NEWIP"
NEWCTY=$(whois $NEWIP | grep -i country | head -n 1 | awk '{print $NF}')
echo "And your new country is $NEWCTY"
else
echo "You are already anonymous."
fi
