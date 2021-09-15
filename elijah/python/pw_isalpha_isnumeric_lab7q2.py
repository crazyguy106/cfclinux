#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Write a Python program to check the validity of password input by users - has number and letters.

#assign variables
alpha = digit = False

#fetch user's input
password=input("Enter your password: ")

#cycle through each character in the password and assign the value 'True' if conditions are met
for char in password:
	if char.isalpha():
		alpha=True
	elif char.isnumeric():
		digit=True

#checks if both variables for alpha and digit are 'True'			
if alpha==True and digit==True:
	print("Your password contains both numbers and letters")
else:
	print("Your password is not alphanumeric.")
