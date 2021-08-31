#!/usr/bin/python3

dictionary = {'my_string': 'Steven Chia', 50: 'I am number fifty'}

# Get data
var = dictionary['my_string']
print(var)

# Update data
dictionary['my_string'] = 'I have been changed'
print(dictionary)

# Delete data (pop)
dictionary.pop('my_string')
print('After deleting', dictionary)

# add data

# Questions
value_from_50 = dictionary['50']
print('test', value_from_50)
