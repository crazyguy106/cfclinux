#!/usr/bin/python3

path_to_file = input('Path to file: ')

with open(path_to_file, 'r') as f:
	data = f.read()
	
num_lines = len(data.split('\n'))
print(num_lines)
