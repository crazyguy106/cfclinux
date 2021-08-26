#!/bin/bash

#~ Create a code the will get a domain name and: 
#~ 1.	Return the IP address
#~ 2.	Save the whois data into a file (the name of the file should be the domain name)

#Request domain address from user
read -p "Please enter a domain name: " DOMAIN

if [[ "$DOMAIN" > 0 ]]; then 

	#Fetch domain name's IP address
	IP=`dig +short $DOMAIN | head -n 1`

		if [ ! -z "$IP" ]; then


			echo "Domain IP Address: $IP"

			#Fetch domain name whois data
			whois $DOMAIN > $DOMAIN.txt
			echo "================================================"
			echo
			echo "The file $DOMAIN.txt has been created." 
			echo
			echo "================================================"
			echo

		else
			echo
			echo "Unable to fetch the IP address of the domain name."
			echo "Please run $0 again."
			echo
			exit 1
  
		fi

else
	echo
	echo "Domain address not entered."
	echo "Please run $0 again."
	echo
	exit 1
fi
