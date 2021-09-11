#!/usr/bin/python3
import os
import hashlib

for name in os.listdir('.'):
	if os.path.isfile(name):
		with open(name, 'rb') as f:	
			data = f.read()
			hashed = hashlib.md5(data).hexdigest()
			
		print(f'{name} has a md5 hash of {hashed}')
