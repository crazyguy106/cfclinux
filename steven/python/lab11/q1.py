#!/usr/bin/python3
import hashlib

m = hashlib.md5(b'a').hexdigest()

print(m)
