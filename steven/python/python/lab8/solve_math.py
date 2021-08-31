#!/usr/bin/python3

x = int(input('Enter an x: '))
y = int(input('Enter an y: '))

def solve_math(x, y):
	return (x + y) * (x + y)
	
answer = solve_math(x, y)

print(f'Your answer is {answer}')
