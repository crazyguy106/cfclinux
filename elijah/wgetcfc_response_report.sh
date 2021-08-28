#!/bin/bash

#set $1 var
echo "Press 'Enter' to wget the default IP: 128.199.107.140"
read -p "or input another IP address or domain name to wget: " IP

#Set IP var if no user input is captured
if [ -z "$IP"]; then
	IP=128.199.107.140
fi

#Request for the number of interation
read -p "Enter the range for the loop interation: " RANGE
echo "Searching..."
#for loop iteration
for n in $(seq $RANGE)
do 
COUNT="$n"
	#output wget server response status to wget.txt
	$(wget -a wget.txt $IP/$n --server-response $IP/Sn)
	#Search for the string 'Saving' and pass into a variable
	STRING=$(cat wget.txt | awk '/Saving/{print $NF}')
	#check is STRING is empty
	if [ ! -z $STRING ]; then
		echo
		echo "============== File(s) Captured =============="
		echo "The file $(cat wget.txt | awk '/Saving/{print $NF}') was found at the "$n"th loop."
		echo "=============================================="
		echo
	fi

	#Remove wget.txt
	rm wget.txt
done
echo "$STRING"
if [ -z $STRING ] && [ "$RANGE" = "$n" ]; then
	echo "=============================================="
	echo "No files were found at the "$COUNT"th loop."
	echo "=============================================="
	echo
fi
