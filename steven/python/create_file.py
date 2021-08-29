#!usr/bin/python3

username = input('What is your username? ')
age = input('What is your age? ')

with open('user and age.txt', 'w') as f:
	f.write(f'{username} is {age} years old')
