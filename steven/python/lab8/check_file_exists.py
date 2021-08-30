#!/usr/bin/python3

import os

file_path = input('Please enter the file path that would like to check: ')

def check_file_exists(file_path):
	if os.path.isfile(file_path):
		file_size = os.path.getsize(file_path)
		
		print(f'The size of {file_path} is {file_size} bytes')
		
	else:
		print('The file does not exist')
		
check_file_exists(file_path)
