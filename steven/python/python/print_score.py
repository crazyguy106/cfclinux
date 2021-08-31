#!/usr/bin/python3

# Read data and get average score
with open('student scores.txt', 'r') as f:
	data = f.read()

num_scores = 0
total_score = 0

for line in data.split('\n')[:-1]:
	score = int(line.split(': ')[1])
	num_scores += 1
	total_score += score
	
	print(line)
	
# Present average score
average_score = total_score / num_scores
print(f'The average score attained by students is {average_score}')
