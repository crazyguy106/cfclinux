#!/usr/bin/python3

# Full code
for i in range(len(subject_list)):
	subject = subject_list[i]
	print('The item in index ' + str(i) + ' is ' + subject)
# =========================================================

# Now let's break this down step by step

# length of list is 5
print(len(subject_list))

# range of the length of the list creates a sequence of numbers from 0 to 4
print(range(len(subject_list)))

# running a for loop over the sequence of numbers gives us access to every number from 0 to 4
for i in range(len(subject_list)):
	print(i) 
	
# The numbers 0 to 4 helps us to access the item in list's index
for i in range(len(subject_list)):
	subject = subject_list[i]
	print(subject)
