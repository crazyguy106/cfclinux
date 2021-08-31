#!/usr/bin/python3

# Dictionaries are another way to store data
# List is like a bucket of things insde
# Dictionary is more like a phone's contact list. 
# You can only find a phone number if you know the person's name

# An empty dictionary
dictionary_empty = {}
print(type(dictionary_empty), dictionary_empty)

# Dictionary with items inside
dictionary = {'my_string': 'Hello World', 'my_num': 10, 5: 'The number five!'}
print(dictionary)

# How to create dictionaries in a more readable way
dictionary_neat = {
	'my_string': 'Hello World',
	'my_num': 10,
	5: 'The number five!'
}
print(dictionary_neat)
