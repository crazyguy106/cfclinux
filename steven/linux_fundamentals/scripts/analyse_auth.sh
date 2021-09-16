#!/bin/bash

# Analyse the user's auth.log and returns pertinent information

# Get auth.log
log=$1

# Number of failed attempts on system
num_failed=$(cat $log | grep Failed | wc -l)
echo "Number of failed attempts made on system: $num_failed"

# Number of IP addresses involved in the attacks
num_ip_addresses=$(((cat $log | grep Failed | awk '{print $(NF-3)}') && (cat $log | grep Invalid | awk '{print $(NF-2)}')) | sort | uniq | wc -l)
echo "Number of Ip addresses involved in attacks: $num_ip_addresses"

# Number of valid users with Failed attempts
num_valid_users_failed=$(cat $log | grep Failed | grep -v invalid | awk '{print $(NF-5)}' | sort | uniq | wc -l)
echo "Number of valid users with Failed attempts: $num_valid_users_failed"

# Number of invalid user attempts
num_invalid=$(cat $log | grep Invalid | wc -l)
echo "Number of invalid user attempts: $num_invalid"

# IP address with most Failed attempts + no. of failed attempts and which country attacker is from
most_attacks_info=$(cat $log | grep Failed | awk '{print $(NF-3)}' | sort | uniq -c | sort -g | tail -n 1)
most_attacks_num_attacks=$(echo $most_attacks_info | awk '{print $1}')
most_attacks_ip_address=$(echo $most_attacks_info | awk '{print $2}')

most_attacks_country=$(whois $most_attacks_ip_address | grep -i country | awk '{print $2}')

echo "$most_attacks_ip_address from $most_attacks_country had the most failed attempts with $most_attacks_num_attacks failed attempts"

