#!/usr/bin/python3

# Get names and scores from user
f = open('student scores.txt', 'w')

for i in range(5):
	name = input('What is the student\'s name? ')
	score = int(input('What is the student\'s score? '))
	
	f.write(f'{name}: {score}\n')
	f.flush()
	
f.close()	
