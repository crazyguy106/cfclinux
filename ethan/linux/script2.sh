#!/bin/bash

echo "Please name the domain:"
read domain
COUNTRY=$(whois $domain | grep Country | head -n 1 | awk '{print $3}')
echo "And the country is" $COUNTRY
