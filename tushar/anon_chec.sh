#!/bin/bash

echo "Welcome to the Anon Checker, you cheeky bastard."
read -p "What country are you in? " curr_loc 

curr_ip=$(curl -s ifconfig.me)

ip_loc=$(geoiplookup $curr_ip | cut -d " " -f 5)

if [ $ip_loc = "Singapore" ]; then
	echo "You are not anonymous!!"
	echo "Would you like to be?"
	
	PS3="Please choose 1 or 2: "
	select opt in Yes No
	do
		case "$opt" in
			Yes) cd ~/nipe; perl nipe.pl start; cd ~-;
				echo "Nipe started"
				curr_ip=$(curl -s ifconfig.co)
				ip_loc=$(geoiplookup $curr_ip | cut -d " " -f 5)
				if [[ $ip_loc != $curr_loc ]]; then
					echo "You are now anonymous!"
					exit
				else
					echo "Something went wrong!"
					exit 1
				fi
				;;
			No) echo "Thank you for using Anon Checker! Goodbye."
				exit
				;;
			*) echo "That is not a valid option, please try again"
				;;
		esac
	done

fi
