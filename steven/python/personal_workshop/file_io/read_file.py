#!/usr/bin/python3

# Easier to understand on terminal python!

# read
f = open('numbers.txt', 'r')
data_read = f.read()
print(data_read)
f.close()

# readlines
f = open('numbers.txt', 'r')
data_readlines = f.readlines()
print(data_readlines)
f.close()

# readline 
f = open('numbers.txt', 'r')
data_readline = f.readline()
print(data_readline)
f.close()
