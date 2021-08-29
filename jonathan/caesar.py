# Caesar Cypher script
# This script shifts the alphabets by a set number.
# It only considers alphabets, so numerical and special characters do not get shifted

UNICODEUPPERA = ord('A') #65
UNICODEUPPERZ = ord('Z') #90
UNICODELOWERA = ord('a') #97
UNICODELOWERZ = ord('z') #122

def getCypher(c, shift):
	# Use modulus of 26 here, to deal with scenario where user inputs values greater than 26
	shift = (shift % 26) if shift >= 0 else -(abs(shift) % 26)
	
	# In this script we only consider alphabets. Else, just return the character
	if c.isalpha():
		ordVal = ord(c)
		# lower case and uppercase have different values, so we need to check what is the effective range of shifting
		limitValueZ = UNICODEUPPERZ if c.isupper() else UNICODELOWERZ
		limitValueA= UNICODEUPPERA if c.isupper() else UNICODELOWERA

		shifted = int(ordVal + shift)
		
		# shifted value is between a -z or A - Z
		if shifted >= limitValueA and shifted <= limitValueZ:
			return chr(shifted)
		# shifted value is after z or Z, so it needs to be shifted back to the beginning (-26)
		elif shifted > limitValueZ:
			return chr(shifted - 26)
		# shifted value is before a or A, so needs to be shifted to the end (+26)
		elif shifted < limitValueA:
			return chr(shifted + 26)
		
	else:
		return c
		
def convertText(text, shift):
	convertedText = ''
	for c in text:
		convertedText += getCypher(c, shift)
	formatDisplay(text, convertedText)

def formatDisplay(text, convertedText):
	print('---')
	print(text)
	print(' |')
	print(' | Shifted by ' + str(shift))
	print(' v')
	print(convertedText)
	print('---')

text = None
while text != '':
	text = input('Enter the text you want to cypher (blank to exit): \n')
	if len(text) > 0:
		shift = int(input('Enter the shift amount: '))
		convertText(text, shift)

print("Exited script :)")

