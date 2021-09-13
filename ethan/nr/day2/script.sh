#!/bin/bash

DIR=$(ls)

for i in $DIR
do
	sha1sum $i >> shahashes
done
