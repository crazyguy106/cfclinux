#!/usr/bin/python3

# Create a script to look for file duplications: 
# Print the overall size they are taking, and their names and locations
import os
import sys
import hashlib

# Buffer size to read file in 64kb chunks
BUF_SIZE = 65536

def get_hash(file_location):
	"""Get sha1 hash of file"""
	sha1 = hashlib.sha1()
	try:
		with open(file_location, 'rb') as f:
			while True:
				data = f.read(BUF_SIZE)
				if not data:
					break
				sha1.update(data)
	except OSError as e:
		print(f'Unable to access file at {file_location}')
		print(f'error message: {e}')
			
	return sha1.hexdigest()

start_file_location = sys.argv[1]

file_dict = {}

# Recursively walk through all files in all directories
for dir_path, dir_names, file_names in os.walk(start_file_location):
	
	for file_name in file_names:
		# Get file information
		location = os.path.join(dir_path, file_name)
		size = os.path.getsize(location)
		
		# Store file information		
		if size not in file_dict:
			file_dict[size] = {
				'names': [file_name],
				'locations': [location],
				'sizes': [size]
			}
		else:
			file_dict[size]['names'].append(file_name)
			file_dict[size]['locations'].append(location)	
			file_dict[size]['sizes'].append(size)
			
# Store hashes for files with the same file size
hashes_dictionary = {}

for size, info in file_dict.items():
	names = info['names']
	locations = info['locations']
	sizes = info['sizes']
	
	# Skip checks where the file size is unique
	if len(names) < 2:
		continue
		
	for name, location, size in zip(names, locations, sizes):
		sha1_hash = get_hash(location)
		
		# Store hash information		
		if sha1_hash not in hashes_dictionary:
			hashes_dictionary[sha1_hash] = {
				'names': [name],
				'locations': [location],
				'sizes': [size]
			}
		else:
			hashes_dictionary[sha1_hash]['names'].append(name)
			hashes_dictionary[sha1_hash]['locations'].append(location)
			hashes_dictionary[sha1_hash]['sizes'].append(size)
			
duplicate_names = []
duplicate_locations = []
duplicate_sizes = []

for sha1_hash, info in hashes_dictionary.items():
	names = info['names']
	locations = info['locations']
	sizes = info['sizes']
	
	if len(names) > 2:
		continue
	
	duplicate_names.append(names)
	duplicate_locations.append(locations)
	duplicate_sizes.append(sizes)
	
if len(duplicate_names) == 0:
	print(f'No duplicates found after recursive search through {start_file_location}')
else:
	num_duplicates_found = len(duplicate_names)
	print(f'{num_duplicates_found} duplicate(s) have been found after recursive search through {start_file_location}\n')
	for i, (names, locations, sizes) in enumerate(zip(duplicate_names, duplicate_locations, duplicate_sizes)):
		print(f'Duplicate number {i+1}: ')
		
		for name, location, size in zip(names, locations, sizes):
			print(f'{name} can be found in {location} with a file size of {size} bytes')
			
		print('=====================')
