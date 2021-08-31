with open('135', 'r') as f:
	data = f.read()

new_ls = []
for thing in data.split('\\n'):
	if thing.isdigit():
		new_ls.append(thing)
		
print(new_ls)

with open('135_dup', 'w') as f:
	for num in new_ls:
		f.write(num + '\n')
