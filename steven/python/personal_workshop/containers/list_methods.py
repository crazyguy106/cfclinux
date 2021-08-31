#!/usr/bin/python3

# list we will be using in this Python script
lst = [1, 'a', '2', 10.5]
# =================================



# Get data from list
# Get first item (Remember that Python is 0-indexed!
first_item = lst[0]
print('first item', first_item)

# Get last item
last_item = lst[-1]
print('last_item', last_item)
# =================================


# Update data in list
lst[0] = 10
print('After updating list', lst)
# =================================


# Add data to list (append!)
item_to_add = True
lst.append(item_to_add)

print('After adding', lst)
# =================================


# Delete data from list (pop!)
lst.pop()
print('After deleting', lst)
# =================================

# There are more ways of retrieving, adding, updating and deleting data for lists
# Think about what you want to do, and then google!
