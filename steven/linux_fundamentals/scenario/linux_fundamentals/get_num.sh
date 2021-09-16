#!/bin/bash

IP='http://54.93.64.96/'

for i in {1..100000}
do
	wget "$IP$i"
done
