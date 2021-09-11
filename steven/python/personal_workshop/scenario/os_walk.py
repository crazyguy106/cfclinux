#!/usr/bin/python3 
import os

# print(os.getcwd())

# for dirpath, dirnames, filenames in os.walk('.'):
	# print('In {}, we have the directories: {}, and the files: {}'.format(dirpath, dirnames, filenames))
	
# for thing in os.walk('.'):
	# bob = thing[0]
	# sally = thing[1]
	# filenames = thing[2]
	# print('In {}, we have the directories: {}, and the files: {}'.format(filenames, sally, bob))

for dirpath, dirnames, filenames in os.walk('..'):
	print('In {}, we have the directories: {}, and the files: {}'.format(dirpath, dirnames, filenames))

