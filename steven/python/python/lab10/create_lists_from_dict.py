#!/usr/bin/python3

dictionary = {1: 10, 'a': 30, 'b': 20}
keys = []
values = []

for k, v in dictionary.items():
	keys.append(k)
	values.append(v)

print(keys)
print(values)
