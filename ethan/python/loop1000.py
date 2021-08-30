#!/usr/bin/python3

f=open('spam.txt','a')

for i in range(1000):
	no=str(i+1)
	f.write(no+'\n')
	f.flush()

f.close()
