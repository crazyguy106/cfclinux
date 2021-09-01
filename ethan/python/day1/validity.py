#!/usr/bin/python3

password=input("Please put in a password: ")

if len(password) < 6:
	print("Your password needs to have at least 6 characters.")
if not any(char.isdigit() for char in password):
	print("Make sure your password has a number in it.")
if not any(char.isalpha() for char in password):
	print("Make sure your password has letters in it.")
else:
	print("Your password is valid.")
