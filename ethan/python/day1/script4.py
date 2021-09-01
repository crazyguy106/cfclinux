#!/usr/bin/python3

# ALL your readline requirements

file=input("Please input the file you'd like to read:")

with open(file,'r') as f:
	read=f.read()
	print(read)

with open(file,'r') as f:
	rl=f.readline()
	print(rl)

with open(file,'r') as f:
	for i in range(10):
		print(f.readline())
	

with open(file,'r') as f:
	rls=f.readlines()
	print(rls)

with open(file,'r') as f:
	rls=f.readlines()
	for i in rls:
		print(i)
