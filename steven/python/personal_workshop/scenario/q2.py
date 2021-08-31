#!/usr/bin/python3

# Remember to import the os module!
import os

# Change directory
current_directory = os.getcwd()
print('Before changing directory', current_directory)

os.chdir('CheckMe')

new_current_directory = os.getcwd()
print('After changing directory', new_current_directory)
# ===================================================

# Find out which name is a file and not a directory

# How do I know what items in the current directory? (Seems like os.listdir() would do the trick!)
print(os.listdir())

# So it looks like a list of names, how do I know which one is a file? (Seems like os.path.isfile() would do the trick!)
# The next issue is that it accepts the path to the file as the argument, but we have a list
# So to see if a name is a file, we will have to use os.path.isfile() on every file in the list (A for loop would be suitable for this!)

# Store value of os.listdir() into a new variable
items_in_dir = os.listdir()

# Try printing first to see the output, it seems that the output of os.path.isfile() is True and False
# We can use this for an if statement!
for item in items_in_dir:
	print(os.path.isfile(item))

# print the name ONLY if it is a file and NOT a directory
for item in items_in_dir:
	is_file = os.path.isfile(item)
	if is_file:
		print(item)
