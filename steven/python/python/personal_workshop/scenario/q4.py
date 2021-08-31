#!/usr/bin/python3

# Get the sum of all numbers in file

# Copying code from q3.py!
import os
os.chdir('CheckMe')

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
# ===================================================

# Let's continue using transformed_data!

# Method 1 (Using the sum function, can be found by Googling :))
total = sum(transformed_data)
print(total)

# Method 2 (Remember that David covered this? ;))
# Similar to creating a biggest number variable, we now create a "total counter" to keep summing all values

# Create a total counter
total = 0

# Add numbers to the total counter over a for loop
for number in transformed_data:
	total = total + number

# print the total counter
print(total)
