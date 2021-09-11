#!/usr/bin/python3
import hashlib

m = hashlib.sha224(b'a').hexdigest()

print(m)
