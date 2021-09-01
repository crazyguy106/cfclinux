#!/usr/bin/python3

file=input("Please input the file you'd like to read:")

with open(file,'r') as f:
	read=f.read()

with open(file,'r') as f:
	rl=f.readline()

with open(file,'r') as f:
	rls=f.readlines()

print(read)
print(rl)
print(rls)
