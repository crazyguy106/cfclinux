#!/usr/bin/python3

# Example using string's method: isdigit()

# Test cases
my_num = '5'
my_other_num = 'I am not actually a number'

# Apply isdigit() to both test cases and store the result into variables
my_num_is_digit = my_num.isdigit()
my_other_numis_digit = my_other_num.isdigit()

print('5', my_num_is_digit)
print('I am not actually a number', my_other_numis_digit)

# Use boolean value returned for an if statement!
if my_num_is_digit:
	print(my_num, 'is a digit!')
else:
	print(my_num, 'is not a digit!')
