# This script will ask the user whether he wants to write or read a file
#
# Write Mode
# The user can input the file he/she wants to write to, and then inputs
# a name and the score for that name. The user can enter as many as
# he/she wants. To stop entering data, just enter a blank line
#
# Read Mode
# The user can type in the name of the file to be read
# The script will then print out the lines of the file and output the
# average score
#
# Once reading or writing is done, the script will prompt the user to
# either exit or continue with reading or writing another file

def writeFile():
	fileName = input('File to write to: ')
	file = open(fileName, 'w')
	name = None

	while name != '':
		name = input('Enter Name (blank to exit): ').strip()
		if len(name) > 0:
			score = int(input(name + "'s Score: "))		
			file.write(name + ':'+ str(score) + '\n')
	file.close()
	
def readFile():
	fileName = input('File to read from: ')
	file = open(fileName, 'r')
	lines = file.readlines()
	file.close()
	
	total = 0
	count = 0
	for line in lines:
		student = line.split(':')
		name = student[0]
		score = int(student[1])
		total = total + score
		count = count + 1
		print(name, score)
		
	average = total/count
	print('---')
	print('Average =', average)


exitScript = None
while exitScript != 'y':
	operation = input("Write(W) or read(r) file (w/r): ")
	if operation.lower() == 'w':
		writeFile()
		exitScript = input('Exit? (Y/n): ')
	elif operation.lower() == 'r':
		readFile()
		exitScript = input('Exit? (Y/n): ')
	else:
		exitScript = input('command not found. Exit? (Y/n): ')

