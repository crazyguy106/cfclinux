#1/bin/bash

#Create a code that will tell you if you are anonymous or not 

#Ask user for the country
read -p "Enter the country you are using the device in: " COUNTRY_USER_INPUT

case $COUNTRY_USER_INPUT in 
  SG | sg | Singapore | SINGAPORE | singapore )
	echo "You have entered the coutry Singapore." 
	COUNTRY_USER_INPUT="SG"
	;;
  IL | il | Israel | ISRAEL | israel )
	echo "You have entered the country Israel." 
	COUNTRY_USER_INPUT="IL"
	;;
  * )
	echo "Unknow country entered."
	echo "Note: Database only has SG (Singapore) and IL (Israel) for demostrating purposes."
	exit 1
	;;
esac

#Fetch the IP address
IP=$(curl -s ifconfig.co)

#Fetch the IP's Country
COUNTRY_IP=$(whois $IP | grep -i country | head -n 1 | awk '{print $NF}')

echo "The IP address $IP you are using currently is from $COUNTRY_IP."

if [ "$COUNTRY_IP" != "$COUNTRY_USER_INPUT" ]; then
  echo
  echo "=================="
  echo "You are anonymous!"
  echo "=================="
else
  echo
  echo "======================"
  echo "You are not anonymous!"
  echo "======================"
  echo
fi

  
  
