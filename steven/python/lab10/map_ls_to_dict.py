#!/usr/bin/python3

keys = ['key_1', 'key_2']
values = [10, 20]

# Method 1: Iterate over lists and populate dictionary
mapped_dict = {}

for i in range(len(keys)):
	key = keys[i]
	value = values[i]
	
	mapped_dict[key] = value
	
print(mapped_dict)

# Method 2: Unpack lists into dictionary
mapped_dict_2 = dict(zip(keys, values))
print(mapped_dict_2)
