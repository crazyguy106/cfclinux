#!/bin/bash

#reference:
#$(curl -s https://freegeoip.app/xml/$I | grep -i countrycode | sed 's/[><]/ /g' | awk '{print $2}')
#$(whois $IP | grep -i country | head -n 1 | awk '{print $NF}')

#add alias to .zshrc to execute nipeson from everywhere
#alias nipeson='bash /home/kali/nipe/nipe_on.sh'

sudo updatedb
PATH_NIPE=$(sudo locate nipe.pl)
DIR_NIPE=$(echo $PATH_NIPE | sed 's/nipe.pl//')
NIPE_STATUS_F="nipe.status"

function COUNTRY_USER {
	#Ask user for the country
	COUNTRY_CHECKER=0
	while [ "$COUNTRY_CHECKER" -eq 0 ]
	do
		read -p "[?]Enter the country you are using the device in: " COUNTRY_USER_INPUT
		
		case $COUNTRY_USER_INPUT in 
		  SG | sg | Singapore | SINGAPORE | singapore )
			echo -e "[*]You have entered the country as \e[1;31mSingapore\e[0m." 
			COUNTRY_USER_INPUT="SG"
			COUNTRY_CHECKER=1
			;;
		  IL | il | Israel | ISRAEL | israel )
			echo -e "[*]You have entered the country as \e[1;31mIsrael\e[0m." 
			COUNTRY_USER_INPUT="IL"
			COUNTRY_CHECKER=1
			;;
		  * )
			echo "[!]Unknown country entered."
			echo "[Note]Database only has SG (Singapore) and IL (Israel) for demostration purposes."
			;;
		esac
	done
}

function NIPE_START {
cd $DIR_NIPE
echo -e "\n[*]Starting nipe..."
sudo perl $PATH_NIPE start
sleep 1

sudo perl $PATH_NIPE status > $DIR_NIP$NIPE_STATUS_F

echo "[*]Checking nipe status..."
if [ -f "$NIPE_STATUS_F" ]; then
	NIPE_STATUS=$(cat $NIPE_STATUS_F | awk -F ' ' '{print $NF}' | grep '\S' | head -n 1) #disabled. #activated.
	NIPE_ERROR=$(cat $NIPE_STATUS_F | awk -F' ' '{print $2}') #ERROR:
	
	STATUS_CHECKER=0
	while [ "$STATUS_CHECKER" -eq 0 ]
	do
		if [ "$NIPE_ERROR"=="ERROR:" ]; then
			echo "[*]Nipe did not initiate properly. Restaring nipe..."
			sudo perl $PATH_NIPE restart
			sleep 2
			sudo perl $PATH_NIPE status > $DIR_NIP$NIPE_STATUS_F
		fi
		if [ "$NIPE_STATUS"=="activated." ]; then
			cat $NIPE_STATUS_F 
			STATUS_CHECKER=1
		fi
	done
fi

}

function ANON_CHECK {
	#Fetch the IP address
	IP=$(curl -s ifconfig.me)
	
	#Fetch the IP's Country
	COUNTRY_IP=$(curl -s https://freegeoip.app/xml/$IP | grep -i countrycode | sed 's/[><]/ /g' | awk '{print $2}')
	
	echo -e "[*]The IP address $IP you are using currently is from \e[1;31m$COUNTRY_IP\e[0m."
	
	if [ "$COUNTRY_IP" != "$COUNTRY_USER_INPUT" ]; then
	  echo
	  echo "====================="
	  echo -e "[*]You are \e[1;31manonymous\e[0m!"
	  echo "====================="
	else
	  echo
	  echo "============================="
	  echo -e "[!]You are \e[1;31mNOT\e[0m anonymous!"
	  echo "============================="
	  echo
	fi
}

function RM_FILE {
	if [ -f "$NIPE_STATUS_F" ]; then
		rm $NIPE_STATUS_F
		echo -e "\n[*]The file $NIPE_STATUS_F has been removed."
	fi
}

COUNTRY_USER
NIPE_START
ANON_CHECK
RM_FILE

cd ~-
