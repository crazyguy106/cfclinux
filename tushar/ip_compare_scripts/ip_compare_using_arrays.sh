#!/bin/bash

ip_sorter () {
	grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" "$1" | sort | uniq
	}


array_maker () {
	readarray -t iparray < <(ip_sorter "$1")
	}

compare () {
	while read ip ; do
		for E in ${iparray[@]}; do	
			if [[ "$ip" = "$E" ]]; then
				echo
				echo -e "$(tput setaf 1)$(tput setab 7)$ip $(tput sgr 0) found in both files!"
			fi
		done
	done < <(ip_sorter "$1")
	}
	
read -p "Pick first file with IPs for comparison: " ip1
read -p "Pick second file with IPs for comparison: " ip2

	

array_maker "$ip1"
compare "$ip2"
