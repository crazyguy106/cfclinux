#!/usr/bin/python3
import os 

with open('text_file.txt', 'r') as f:
	data = f.read()
	
with open('text_file.txt', 'r') as f:
	data_lines = f.readlines()
	
with open('size_read.txt', 'w') as f:
	f.write(data)
	
with open('size_readlines.txt', 'w') as f:
		f.write(str(data_lines))
		
size_read = os.path.getsize('size_read.txt')
size_readlines = os.path.getsize('size_readlines.txt')

print(f'size of read() is {size_read}')
print(f'size of readlines() is {size_readlines}')
