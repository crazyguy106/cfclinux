#!/usr/bin/python3

#Creates a script that takes a name and score and saves it into a file

file=open('name.txt','w')
score_total=0

for i in range(5):
	name=input("Please input the name:")
	score=input("Please input their score:")
	score_total=score_total+int(score)
	finput="Name: "+name+", Score: "+score
	file.write(finput+'\n')
	file.flush()

file.close()
fread=open('name.txt','r')
fcontent=fread.read()
print(fcontent)
print(score_total/5)

