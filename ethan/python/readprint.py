#!/usr/bin/python3

# Create a script to read the file and to print the lines that it contains

counter=0
f=open('new.txt', 'r')

for i in f:
	#print(i)
	counter=counter+1

f.close()
print("This file has", counter, "lines.")
