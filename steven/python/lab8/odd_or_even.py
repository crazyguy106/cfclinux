#!/usr/bin/python3

user_num = int(input('Please enter a num: '))

def odd_or_even(num):
	if num % 2 == 0:
		return 'even'
	return 'odd'
	
print(odd_or_even(user_num))
