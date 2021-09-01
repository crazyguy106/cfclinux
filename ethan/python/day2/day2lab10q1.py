#!/usr/bin/python3

dct={'asd': 123, 'sad': 321}
dctk=list(dct.keys())
dctv=list(dct.values())
a=''

for i in range(len(dctk)):
	a=a+str(dctk[i])+str(dctv[i])

print(a)
