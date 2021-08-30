#!/usr/bin/python3

# Create a script to look for file duplications: 
# Print the overall size they are taking, and their names and locations
import os

names = []
locations = []
sizes = []

# Recursively walk through all files in all directories
for dir_path, dir_names, file_names in os.walk('/home/kali'):
	
	# Save name, location, size to respective lists
	for file_name in file_names:
		location = os.path.join(dir_path, file_name)
		size = os.path.getsize(location)
		
		names.append(file_name)
		locations.append(location)
		sizes.append(size)
		
for name, size in zip(names, sizes):
	

# Check file size
	
# If same file size, check hash

# If same hash, store names and locations
