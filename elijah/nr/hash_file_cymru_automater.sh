#!/bin/bash

#e8fb95ebb7e0db4c68a32947a74b5ff9
#assign filename variable
S_FILE="hash.scan"

CYMRU_RESULT="cymru.result"
if [ -f "$CYMRU_RESULT" ]; then
	echo -n "" > $CYMRU_RESULT
fi

VIRUSTOTAL_RESULT="virustotal.result"
if [ -f "$VIRUSTOTAL_RESULT" ]; then
	echo -n "" > $VIRUSTOTAL_RESULT
fi

#ask user for a filename with a list of hashes
H_FILE_CHECK=0
while [ "$H_FILE_CHECK" -eq 0 ]
do
	echo
	read -p "[?]Scan a single hash or a list of hash from a file? (s/f) " H_FILE
	case $H_FILE in 
		s |  S )
		read -p "Enter the hash to be scanned: " H_SINGLE
		H_FILE_CHECK=1
		shift
		;;
		f | F )
		read -p "Enter the filename to be scanned: " H_FILENAME
		H_FILE_CHECK=2
		shift
		;;
		* )
		echo "[!]Please enter 's' or 'f' only"
		;;
	esac
done

#copy single hash into $S_FILE
if [ "$H_FILE_CHECK" -eq 1 ]; then
	echo $H_SINGLE > $S_FILE
fi

#copy a list of hash from a file into $S_FILE
if [ "$H_FILE_CHECK" -eq 2 ]; then
	if [ -f "$H_FILENAME" ]; then
		cat $H_FILENAME | sort | uniq > $S_FILE 
	else
		echo -e "\n[!]The file $H_FILENAME does not exist. Please try again."
		exit 1
	fi
fi

#submit each hash in the file to "whois -h hash.cymru.com" for a faster check
if [ -f "$S_FILE" ]; then
	echo -e "\nProceeding to scan with CYMRU..."
	while read line
	do
		S_RESULT=$(whois -h hash.cymru.com "$line" | grep -v "^#" | awk '{print $NF}')
		if [ "$S_RESULT" != "NO_DATA" ]; then
			echo $line >> $CYMRU_RESULT
		fi
	done < $S_FILE
	
	if [ -f "$CYMRU_RESULT" ]; then
		while read cy_hash
		do
			C_RESULT=$(whois -h hash.cymru.com "$cy_hash" | grep -v "^#" | awk '{print $NF}')
			echo "[!]TEAM CYMRU detected viruses with a $C_RESULT% AV-Hit. Hash: $cy_hash"
		done < $CYMRU_RESULT
		echo "[*]The file $CYMRU_RESULT has been generated"
	else
		echo -e "[*]TEAM CYMRU did not detected any viruses"
	fi
fi

#~ #send results to Virustotal to double check
if [ -f "$CYMRU_RESULT" ]; then
	AUTOMATERSCRIPT='bash /home/kali/TekDefense-Automater/automaterscript.sh'
	echo -e "\nProceeding to scan $CYMRU_RESULT with VirusTotal..."
	while read hash
	do
		V_RESULT=$($AUTOMATERSCRIPT $hash | grep -i detected | awk '{print $NF}')
		if [ "$V_RESULT" != 0 ]; then
			echo $hash >> $VIRUSTOTAL_RESULT
		fi
	done < $CYMRU_RESULT
	
	if [ -f "$VIRUSTOTAL_RESULT" ]; then
		while read v_hash
		do
			echo -e "[!]VirusTotal detected viruses. Hash: $v_hash"
		done < $VIRUSTOTAL_RESULT
		echo -e "[*]The file $VIRUSTOTAL_RESULT has been generated"
	else
		echo -e "[*]VirusTotal did not detect any viruses"
	fi
fi

#remove temporary file $F_FILE
if [ -f "$S_FILE" ]; then
rm $S_FILE
echo -e "\n[*]Temporary file $S_FILE removed"
fi

#ask if user wants to remove cymru output file $CYMRU_RESULT
CHECK_RM_CYMRU=0
if [ -f "$CYMRU_RESULT" ]; then
	while [ "$CHECK_RM_CYMRU" -eq 0 ]
	do
		echo
		read -p "[?]Do you want to remove the file $CYMRU_RESULT? (Y/n) " RM_CYMRU_F
		case $RM_CYMRU_F in
		y | Y | yes | Yes | YES )
			rm $CYMRU_RESULT
			echo -e "[*]The file $CYMRU_RESULT has been removed"
			CHECK_RM_CYMRU=1
		shift
		;;
		n | N | no | No | NO )
		if [ -f "$CYMRU_RESULT" ]; then
			echo -e "[*]The file $CYMRU_RESULT has been saved"
			CHECK_RM_CYMRU=1
		fi
		shift
		;;
		* )
		echo -e "[!]No input has been captured! Please enter 'Y' or 'N' only"
		;;
		esac
	done
fi

#ask if user wants to remove virustotal output file $VIRUSTOTAL_RESULT
CHECK_RM_VT=0
if [ -f "$VIRUSTOTAL_RESULT" ]; then
	while [ "$CHECK_RM_VT" -eq 0 ]
	do
		echo
		read -p "[?]Do you want to remove the file $VIRUSTOTAL_RESULT? (Y/n) " RM_VT_F
		case $RM_VT_F in
		y | Y | yes | Yes | YES )
			rm $VIRUSTOTAL_RESULT
			echo -e "[*]The file $VIRUSTOTAL_RESULT has been removed"
			CHECK_RM_VT=1
		shift
		;;
		n | N | no | No | NO )
		if [ -f "$VIRUSTOTAL_RESULT" ]; then
			echo -e "[*]The file $VIRUSTOTAL_RESULT has been saved"
			CHECK_RM_VT=1
		fi
		shift
		;;
		* )
		echo -e "[!]No input has been captured! Please enter 'Y' or 'N' only"
		;;
		esac
	done
fi


