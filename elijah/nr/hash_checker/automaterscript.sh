#!/bin/bash
echo -e "[*]Updatedb in progress..."
sudo updatedb
echo "Updatedb completed"
PATH_L=$(locate Automater.py | sed 's/Automater.py//g')
cd $PATH_L ; python Automater.py $1 ; cd ~-
