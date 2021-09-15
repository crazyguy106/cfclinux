#!/bin/bash

#assign filename variable
S_FILE="hash_dir.scan"

CYMRU_RESULT="cymru_dir.result"
if [ -f "$CYMRU_RESULT" ]; then
	echo -n "" > $CYMRU_RESULT
fi

VIRUSTOTAL_RESULT="virustotal_dir.result"
if [ -f "$VIRUSTOTAL_RESULT" ]; then
	echo -n "" > $VIRUSTOTAL_RESULT
fi

#ask user for a directory path or a file containing hashes
H_DIR_CHECK=0
while [ "$H_DIR_CHECK" -eq 0 ]
do
	echo -e "\nTo hash the files in a folder, "
	read -p "please enter the path to the directory. For example: /home/kali " H_DIR
	if [ -d "$H_DIR" ]; then
		H_DIR_CHECK=1
	else
		echo "The directory $H_DIR does not exist. Please try again."
	fi
done

#hash the files in the directory and save the hashes into a file
if [ "$H_DIR_CHECK" -eq 1 ]; then
	md5sum $H_DIR/* > $S_FILE
fi

#submit each hash in the file to "whois -h hash.cymru.com" for a faster check
if [ -f "$S_FILE" ]; then
	echo -e "\nProceeding to scan with CYMRU..."
	while read line
	do
		LINE_S1=$(echo -n $line | awk '{print $1}')
		S_RESULT=$(whois -h hash.cymru.com "$LINE_S1" | grep -v "^#" | awk '{print $NF}')
		if [ "$S_RESULT" != "NO_DATA" ]; then
			echo $line >> $CYMRU_RESULT
		fi
	done < $S_FILE
	
	if [ -f "$CYMRU_RESULT" ]; then
		while read cy_hash
		do
			LINE_C1=$(echo -n $cy_hash | awk '{print $1}')
			LINE_C2=$(echo $cy_hash | awk '{print $2}' | sed -e 's/\// /g' | awk '{print $NF}')
			C_RESULT=$(whois -h hash.cymru.com "$LINE_C1" | grep -v "^#" | awk '{print $NF}')
			echo "[!]TEAM CYMRU detected viruses with a $C_RESULT% AV-Hit. Hash: $LINE_C1 Filename: $LINE_C2"
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
			LINE_V1=$(echo -n $v_hash | awk '{print $1}')
			LINE_V2=$(echo $v_hash | awk '{print $2}' | sed -e 's/\// /g' | awk '{print $NF}')
			echo -e "[!]VirusTotal detected viruses. Hash: $LINE_V1 Filename: $LINE_V2"
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

