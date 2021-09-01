a='Hello class'
b=2341
c=[1, 2, 3, 'a4paper', '789']
d={1: 'rocks', 200: 'Jammin', 404: 'Error'}

print(a)
print(b)
print(c)
print(d)

print(a[0])
print(a[-1])
print(c[0])
print(c[-1])
# printing dict items
print(list(d.items())[0],list(d.items())[-1])
# printing dict characters
print(str(d)[0],str(d)[-1])
# printing dict as is
# print(d[0][0])
# print(d[-1][-1])

print(c.pop())
print(c)

d[2]='paper'
print(d)

print(a+a)

print(len(c))
c.append('hello')
print(len(c))

print(d.keys())

