#!/usr/bin/python3

while True:
	try:
		a=input("Please input a file you want to analyse: ")
		add=open('filenames.txt','a')
		add.write(a+'\n')
		add.flush()
		file=open(a,'r')
		file.read()
		file.close()
		break
	except:
		print("The filename doesn't exist! Please try again.")
	
print("That file exists!")
