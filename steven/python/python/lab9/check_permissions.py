#!/usr/bin/python3

file_names = ['remove_dupl.py', 'sum_nums.py']

with open('files with read permissions.txt', 'w') as f:
	for file_name in file_names:
		try:
			check_file = open(file_name, 'r')
			check_file.close()
			
			f.write(file_name + '\n')
			f.flush()
		except:
			pass
			
