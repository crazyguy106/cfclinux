#!/usr/bin/python3

hours = int(input('Please enter number of hours: '))

def convert_hours_to_seconds(hours):
	return hours * 60 * 60
	
num_seconds = convert_hours_to_seconds(hours)
print(f'{hours} hours is equivalent to {num_seconds} seconds')
