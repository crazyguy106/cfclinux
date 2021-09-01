#!/usr/bin/python3

lst1=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 124, 11]
lst2=['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'z']

dct = dict(zip(lst1, lst2))

print(list(zip(lst1, lst2)))
print(dct)
