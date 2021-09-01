def complex():
	x1=input("1st number: ")
	y1=input("2nd number: ")
	x=int(x1)
	y=int(y1)
	z=((x+y)*(x+y))
	print(z)
	
#complex()

def h2scon():
	hr=input("Number of hours to convert into seconds: ")
	s=int(hr)*60*60
	print(s)

#h2scon()

a=[8,2,3,0,7]


def sum(lst):
	total=0
	for i in lst:
		total=total+(int(i))
	print(total)

sum(a)
