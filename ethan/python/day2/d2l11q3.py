#!/usr/bin/python3

import hashlib, os
hashes=[]

fns=[ f for f in os.listdir() if os.path.isfile(f) ]
for f in fns:
	print(f)
	fr=open(f,'rb')
	hashed=hashlib.md5(fr.read()).hexdigest()
	
