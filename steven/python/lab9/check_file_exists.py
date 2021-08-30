#!/usr/bin/python3

file_name = input('Please enter a file name: ')

# I like specifying the type of error!
try:
	f = open(file_name)
	f.close()
	print(f'{file_name} can be found in the current directory')
except FileNotFoundError as e:
	print('The file is not found')
	print('error message:', e)
