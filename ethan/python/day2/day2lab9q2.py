#!/user/bin/python3

a=input("Input the first number: ")
b=input("Input the second number: ")
c=input("Input the third number: ")
d=input("Input the fourth number: ")
e=input("Input the fifth number: ")

lst=[a,b,c,d,e]

x=0

for i in lst:
	x=x+int(i)

print("The total sum is",x)
