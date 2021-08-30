#!/usr/bin/python3

with open('student scores.txt', 'r') as f:
	read_data = f.read()
	
with open('student scores.txt', 'r') as f:
	readline_data = f.readline()
	
with open('student scores.txt', 'r') as f:
	readlines_data = f.readlines()
	
print(repr(read_data))
print(readline_data)
print(readlines_data)
