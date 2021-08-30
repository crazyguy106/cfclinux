#!/usr/bin/python3

ls = [1,2,3,4,5,6,7]

def print_even(ls):
	for num in ls:
		if num % 2 == 0:
			print(num)
			
print_even(ls)
