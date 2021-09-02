#!/usr/bin/python3 
#Create a program that prints the filenames in a directory and their hash.
#fCreate a script to look for file duplications: print the overall size they are taking, and their names and locations.

import os
import hashlib

dup_dct={} #to store duplicate files and its file size, hash and location
tmp_dct={} #to store other files and its file size, hash and location
info_dct={} #to store all files and its file size, hash and location
err_dct={} #to store unreadable files
os.remove('filename_hash.txt')
for roots, dirs, files in os.walk('.'):
	for fi in sorted(files):
		try:
			with open(os.path.join(roots,fi), 'r') as f:
				f_data=f.read()
			f_hash=hashlib.md5(f_data.encode()).hexdigest()
			f_size=os.path.getsize(os.path.join(roots,fi))
			f_loc=roots
			info_dct[fi]=f_size, f_hash, f_loc
		except:
			f_hash=""
			err_dct[fi]=f_size, f_hash, f_loc
			
#iterate over all captured files in the dict		
for k1, v1 in info_dct.items():
	tmp_hash=v1[1]
	tmp_dct[k1]=v1
	
	#interate over and comapare the hash value
	for k2, v2 in info_dct.items():
		if not k2 in tmp_dct:
			if tmp_hash==v2[1]:
				tmp_dct[k2]=v2
				dup_dct[k2]=v2
				dup_dct[k1]=v1
				
count_dup=len(dup_dct)
total_dup_size=float()
print("\nThe report below has been saved to filename_hash.txt in the current directory.\n")
for k, v in dup_dct.items():
	total_dup_size+=float(v[0])
s1="No. of Duplicated files: {}".format(count_dup)		
print(s1)
with open('filename_hash.txt', 'a') as fht:
	fht.write(s1+"\n")
s2="Total file size: {} bytes".format(total_dup_size)
print(s2)
with open('filename_hash.txt', 'a') as fht:
	fht.write(s2+"\n")
s3='-'*80
print(s3)
with open('filename_hash.txt', 'a') as fht:
	fht.write(s3+"\n")
#iterate over the duplicate files dict
for k3, v3 in dup_dct.items():
	s4="{0}: {1[0]} bytes. Hash: {1[1]}. Location: {1[2]}".format(k3,v3)
	print(s4)	
	with open('filename_hash.txt', 'a') as fht:
		fht.write(s4+"\n")
count_other=len(tmp_dct)-len(dup_dct)
s5="\nNo. of other files: {}".format(count_other)
print(s5)
with open('filename_hash.txt', 'a') as fht:
	fht.write(s5+"\n")
s6='-'*80
print(s6)
with open('filename_hash.txt', 'a') as fht:
	fht.write(s6+"\n")
#iterate over other files dict
for k4, v4 in tmp_dct.items():
	if not k4 in dup_dct:
		s7="{0}: {1[0]} bytes. Hash: {1[1]}. Location: {1[2]}".format(k4,v4)
		print(s7)
		with open('filename_hash.txt', 'a') as fht:
			fht.write(s7+"\n")

count_err=len(err_dct)
s8="\nNo. of unreadable files: {}".format(count_err)
print(s8)
with open('filename_hash.txt', 'a') as fht:
	fht.write(s8+"\n")
s9='-'*80
print(s9)
with open('filename_hash.txt', 'a') as fht:
	fht.write(s9+"\n")
#iterate over unreadable files dict
for k5, v5 in err_dct.items():
	s10="{0}: {1[0]} bytes. Hash: None. Location: {1[2]}".format(k5,v5)
	print(s10)
	with open('filename_hash.txt', 'a') as fht:
		fht.write(s10+"\n")
	

