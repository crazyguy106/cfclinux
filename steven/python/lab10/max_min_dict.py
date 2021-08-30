#!/usr/bin/python3

dictionary = {1: 10, 'a': 30, 'b': 20}

values = []
for val in dictionary.values():
	values.append(val)
	
print('max:', max(values))
print('min:', min(values))
