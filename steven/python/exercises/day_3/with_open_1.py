#!/usr/bin/python3

char_to_check = 'a'

with open('text_file.txt', 'r') as f:
	data = f.read()
	
# a.
if char_to_check in data:
	print(char_to_check, 'is inside the file!')
else:
	print(char_to_check, 'is not inside the file!')

num_appearances = data.count(char_to_check)
print(f'{char_to_check} appeared {num_appearances} times')

# b.
with open('text_file.txt', 'r') as f:
	data_lines = f.readlines()
	
num_appearances_lines = 0
for line in data_lines:
	if char_to_check in line:
		num_appearances_lines += 1
		
print(f'{char_to_check} appeared in {num_appearances_lines} lines')
