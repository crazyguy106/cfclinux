#!/bin/bash

Failed=$(cat $1 | grep Failed | wc -l)
(cat $1 | grep Failed | awk '{print $(NF-3)}' && cat $1 | grep Invalid | awk '{print $(NF-2)}') | sort | uniq > ipblack.txt
cat $1 | grep Accepted | awk '{print $(NF-3)}' | uniq > ipwhite.txt
ipno=$(grep -v -f ipwhite.txt ipblack.txt | wc -l)
Fuser=$(cat $1 | grep Failed | grep -v invalid | awk '{print $(NF-5)}' | sort | uniq)
invalid=$(cat $1 | grep Invalid | awk '{print $8}' | wc -l)
ipfail=$(cat $1 | grep Failed | awk '{print $(NF-3)}' | sort | uniq -c | sort -g | tail -n 1 | awk '{print $2}')
ipfailno=$(cat $1 | grep Failed | awk '{print $(NF-3)}' | sort | uniq -c | sort -g | tail -n 1 | awk '{print $1}')
country=$(whois $ipfail | grep -i country | head -n 1 | awk '{print $NF}')

echo "This script is to analyse the following results:"

echo "1. The number of Failed attempts made on his system is" $Failed
echo "2. The number of IP addresses involved in the attacks is" $ipno
echo "3. The valid users with failed attempts are:"$Fuser
echo "4. The number of invalid user attempts is" $invalid
echo "5. The IP address with the most failed attempts is "$ipfail "who failed "$ipfailno "times and is from "$country
