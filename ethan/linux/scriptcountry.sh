#!/bin/bash

#Create a script to find out the countries of IPs in the list

for i in $(cat $1)

do

echo $i
whois $i | grep -i country | head -n 1 | awk {'print $2'}

done
