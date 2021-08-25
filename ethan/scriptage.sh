#!/bin/bash

#This is to check if I'm in Singapore to make me anonymous - grep with whois

function good()
{
	echo "You're of age!"
}

function bad()
{
	echo "You're too young!"
}

read -p "Please give your age:" age

if [ "$age" -ge "30" ]
then
good

else
bad
fi
