#!/usr/bin/python3

lst=['a','c','a','a','b','d','e','r','x','a']

# Easy way
lst_removed = list(set(lst))
print(lst_removed)

# Correct way (?)
lst_removed = []

for thing in lst:
	if thing not in lst_removed:
		lst_removed.append(thing)
		
print(lst_removed)
