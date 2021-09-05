#!/usr/bin/python3
import os

with open('wb.txt','r') as f:
	data=f.read()

if 'guidelines' in data.lower():
	print(data.lower().count('guidelines'))
else:
	print("There is no string.")


counter=0
with open('wb.txt','r') as f:
	frl=f.readlines()
	for i in frl:
		if 'z' in i:
			counter=counter+1

print("The number of lines that contain z in wb.txt is "+str(counter))

with open('wb.txt','r') as f:
	frl=f.readlines()
	rlsize=open('rl','w')
	rlsize.write(str(frl))
	rlsize.close()

with open('wb.txt','r') as f:
	fr=f.read()
	rsize=open('r','w')
	rsize.write(fr)
	rsize.close()

print("Readlines is "+str(os.path.getsize('rl'))+" while read is "+str(os.path.getsize('r')))
