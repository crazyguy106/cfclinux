#!/bin/bash

ip_sorter () {
	grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" "$1" | sort | uniq
	}

file_maker () {
	mkdir tmp
	ip_sorter "$1" > tmp/file1
	ip_sorter "$2" > tmp/file2
	}
	
compare () {
	cd tmp
	for ip in $(comm -12 file1 file2); do
		echo -e "$(tput setaf 1)$(tput setab 7)$ip $(tput sgr 0) found in both files!"
	done
	}
	
cleanup () {
	cd ~-
	rm -rf tmp
	}
	
read -p "Pick first file with IPs for comparison: " ip1
read -p "Pick second file with IPs for comparison: " ip2

file_maker "$ip1" "$ip2"

compare

cleanup
