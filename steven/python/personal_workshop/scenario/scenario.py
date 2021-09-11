#!/usr/bin/python3

import os
os.chdir('CheckMe')

f = open('135', 'r')
data = f.read()
f.close()

print(data)
