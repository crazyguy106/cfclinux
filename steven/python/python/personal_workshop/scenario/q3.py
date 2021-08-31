#!/usr/bin/python3

# Get the largest number in the file

# Copying code from q2.py so that we are on the right directory
import os
os.chdir('CheckMe')
# ===================================================

# We know that there is data inside the file, let's see what is inside
f = open('135', 'r')

# For now, let's just see what's inside!
data = f.read()
print(data)

# Remember to close the file!
f.close()

# The data looks like a lot of numbers, with a lot of '\n' symbols. 
# How do we get the largest number from this data? We will need to break this down into multiple steps
# ===================================================

# Here are some questions that may help in knowing what steps to take

# 1. What kind of output do I want? (A number!)
# 2a. What kind of data will I need to get this output? (string? list?)
# 2b. What kind of process would be useful to get this output? (for loop?)

# It can also be useful to write pseudo code (plain language description of steps to take)
# And turn the pseudo code into Python code
# Let's use try this to solve this question

# Method 1 (Remember how David sorted a list of numbers to get the largest number in the last index of the list?)

# Get data from file as a list
f = open('135', 'r')
data = f.readlines()
f.close()

# convert contents of the list into numbers
transformed_data = []

for number in data:
	# Remove \n
	stripped_number = number.strip('\n')
	# Convert to integer
	transformed_number = int(stripped_number)
	# Append transformed number to new list
	transformed_data.append(transformed_number)

# sort content of list
sorted_transformed_data = sorted(transformed_data)

# Get last index
biggest_number = sorted_transformed_data[-1]
print(biggest_number)
# ===================================================



# Method 2 (max function, you may have found this while googling!)

# Since we can immediately get the max number from a list, we do not need to sort it!
# However, we do still need a list of numbers
biggest_number = max(transformed_data)
print(biggest_number)
# ===================================================



# Method 3 (Keep track of biggest number)

# Create a variable that keeps track of the biggest number
biggest_number = transformed_data[0]

# Use a for loop over the list and check if the number is bigger than the current biggest number
for number in transformed_data:
	# If the number is bigger, replace the biggest number variable with the current number
	if number > biggest_number:
		biggest_number = number

# print the biggest number
print(biggest_number)
