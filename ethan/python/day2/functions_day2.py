#!/usr/bin/python3

#def reversal(x):
#	return x[::-1]

#print(reversal('What do you think?'))

def unique(lst):
	x=[]
	for i in lst:
		if i not in x:
			x.append(i)
	return x

a=[1,2,3,3,3,3,4,5]
#print(unique(a))

def even_no(lst):
	x=[]
	for i in lst:
		if i%2==0:
			x.append(i)
	return x

print(even_no(a))
