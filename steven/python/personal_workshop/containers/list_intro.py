#!/usr/bin/python3

lst = [1, 'a', '2', 10.5]

# Get data from the list
last_item = lst[-1]

print(last_item)

# Update data
lst[-1] = 'I have changed'
print('After updating', lst)

# Delete data  (pop)
lst.pop()
print('After deleting', lst)

# add data (append)
lst.append(10)
print('after adding', lst)
