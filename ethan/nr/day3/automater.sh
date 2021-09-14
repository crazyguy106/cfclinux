#!/bin/bash
md5sum * > md5.hashes
cp md5.hashes ~/automater
cd ~/automater
mkdir results
IFS=$'\n'
for i in $(cat md5.hashes)
do
	HASH=$(echo $i | awk '{print $1}')
	FN=$(echo $i | awk '{print $2}')
	python Automater.py $HASH > results/$FN.vt
	YV=$(cat results/$FN.vt | grep Vendor | grep -v No)
	if [ -n "$YV" ]
		then 
		echo "$FN has the following flags:"
		echo "$YV"
	fi
done
rm md5.hashes
cd ~-
mv ~/automater/results .
