#!/usr/bin/python3

# What happens when we read a file that does not exist?
# f = open('not here.txt', 'r')
# f.close()

# print('hello world')

# Now let's add a try-except statement so that our code will run!
try:
	f = open('not here.txt', 'r')
	f.close()
	print('The file was opened and closed!')
except:
	print('There was an error, but let us run the rest of the code anyway')
	
print('hello world')
