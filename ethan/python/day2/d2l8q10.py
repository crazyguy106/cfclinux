#!/usr/bin/python3

import os

chkfl=input("Please input the file you'd like to check: ")

if os.path.isfile(chkfl):
	a=str(os.path.getsize(chkfl))
	print("The file is "+a+"bytes")
else:
	print("This is not a file")
