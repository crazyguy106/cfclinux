#!/bin/bash


# MUST run from same folder as Automater

while read file; do
	if [[ -f $file ]]; then
		echo "$file is a file"
		res=$(md5sum $file | cut -d " " -f 1)
		echo $res >> hashlist.txt
	else
		echo "$file is not a file"
	fi
done < <(ls .)

while read hash; do
	python ~/TekDefense-Automater/Automater.py $hash 
done < hashlist.txt

rm hashlist.txt
