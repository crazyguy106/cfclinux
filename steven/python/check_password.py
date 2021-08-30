#!/usr/bin/python3

password = input('Please enter your password: ')

has_upper = False
has_lower = False
has_special = False
has_numbers = False

for char in password:
	if char.isupper():
		has_upper = True
	if char.islower():
		has_lower = True
	if not char.isalnum():
		has_special = True
	if char.isdigit():
		has_numbers = True
		
num_conditions_passed = has_upper + has_lower + has_special + has_numbers

if num_conditions_passed >= 3:
	print('Great password!')
else:
	print('Man... what a shitty password')
