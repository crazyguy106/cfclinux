#!/usr/bin/python3

# Dictionary we will be using in this Python script
dictionary = {
	'my_string': 'Hello World',
	'my_num': 10,
	5: 'The number five!'
}
# =================================



# Get data from dictionary 
# Instead of getting data based on index, we need to know the key!
item_1 = dictionary['my_string']
item_2 = dictionary[5]

print('Value by accessing using key my_string', item_1)
print('Value by accessing using key 5', item_2)
# =================================


# Update data in dictionary
dictionary['my_string'] = 'I have been hacked! Help me!'
print('After updating', dictionary)
# =================================


# Add data to dictionary
dictionary['new_data'] = 'I am a new string in the dictionary!'
print('After adding data', dictionary)
# =================================


# Delete data in dictionary
dictionary.pop('new_data')
print('After deleting data', dictionary)
